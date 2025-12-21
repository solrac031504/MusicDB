# Loads the Genre and GenreHierarchy tables from a JSON file
import json
import os
from dotenv import load_dotenv
import pandas as pd
from pandas.api.types import is_bool_dtype, is_datetime64_dtype, is_float_dtype, is_integer
import sqlalchemy
from sqlalchemy import create_engine, outparam, text, bindparam
import logging

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class GenreETLPipeline:
    def __init__(self, db_connection_string):
        """
        Initialize ETL Pipeline for Genre and Genre Hierarchy

        Parameters:
        - db_connection_string: Database connection string
        """
        self.db_connection_string = db_connection_string
        self.engine = None
        self.genre_df = None
        self.hierarchy_df = None

    def connect_to_database(self):
        """Establish database connection"""
        try:
            self.engine = create_engine(self.db_connection_string)
            logger.info("Database connection established successfully")
            return True
        except Exception as e:
            logger.error(f"Failed to connect to database: {e}")
            return False

    def extract_from_json(self, json_file_path):
        """
        Extracts data from JSON file into pandas DataFrame

        Parameters:
        - json_file_path: Path to JSON file
        """
        try:
            # Data structures
            genre_to_id = {}
            genre_rows = []
            relationship_rows = []
            current_id = [1]
            seen_relations = set()

            """
            Generates a new ID for each seen genre
            given the genre hasn't been seen yet
            """
            def get_or_create_genre_id(name):
                if name not in genre_to_id:
                    genre_to_id[name] = current_id[0]
                    genre_rows.append((current_id[0], name))
                    current_id[0] += 1
                return genre_to_id[name]

            """
            Adds a new parent-child relationship to the hierarchy
            given it hasn't been seen before
            """
            def add_relationship(child, parent):
                child_id = get_or_create_genre_id(child)
                parent_id = get_or_create_genre_id(parent) if parent else None
                if (child_id, parent_id) not in seen_relations:
                    relationship_rows.append((child_id, parent_id))
                    seen_relations.add((child_id, parent_id))

            """
            Traverses the JSON genre hierarchy
            """
            def traverse_tree(tree, child=None):
                if not isinstance(tree, dict):
                    return

                for key, val in tree.items():
                    # If the child exists, add relationship
                    if child:
                        add_relationship(child, key)
                    # If key has no child, is root
                    else:
                        # Key is a root node
                        add_relationship(key, -1)
                    # If the key value is a dict, recurse
                    if isinstance(val, dict):
                        traverse_tree(val, child=key)
                    # If the key val is NULL, is root
                    elif val is None:
                        add_relationship(key, -1)
            
            # Load JSON data
            with open(json_file_path, 'r') as file:
                genres = json.load(file)

            # Iterate through JSON and create tuples for genre and hierarchy info
            for outer_key, outer_val in genres.items():
                traverse_tree(outer_val, child=outer_key)
                get_or_create_genre_id(outer_key)
                # If no parents, add -1 parent entry
                if outer_val is None:
                    add_relationship(outer_key, -1)

            # Separate the tuples into two arrays
            genre_ids = [genre_id for genre_id, _ in genre_rows]
            genre_names = [genre_name for _, genre_name in genre_rows]
            relationship_genre_ids = [child_genre_id for child_genre_id, _ in relationship_rows]
            relationship_parent_ids = [parent_genre_id for _, parent_genre_id in relationship_rows]

            # Load into DFs
            self.genre_df = pd.DataFrame({
                'GenreId': genre_ids,
                'GenreName': genre_names
            })

            self.hierarchy_df = pd.DataFrame({
                'GenreId': relationship_genre_ids,
                'ParentGenreId': relationship_parent_ids
            })

            logger.info("Loaded JSON data into data frames")
            return True
        except Exception as e:
            logger.error(f"Error when extracting JSON data: {e}")
            return False

    def truncate_stage_tables(self):
        """Truncate staging tables"""
        try:
            with self.engine.connect() as conn:
                conn.execute("TRUNCATE TABLE stage.Genre")
                conn.execute("TRUNCATE TABLE stage.GenreHierarchy")
                conn.commit()

            logger.info("Successfully truncated Genre and GenreHierarchy stage tables")

            return True
        except Exception as e:
            logger.error(f"Failed to truncate stage table: {e}")
            return False

    def load_to_stage_table(self):
        """Load DataFrame to staging tables"""
        try:
            if self.genre_df is None or self.hierarchy_df is None:
                logger.warning("At least one data frame is empty")
                return False

            # Load DataFrame to SQL
            self.genre_df.to_sql(
                name="Genre",
                con=self.engine,
                schema="stage"
                if_exists='append'
                index=False
                dtype=self._get_column_dtypes()
            )

            logger.info(f"Successfully loaded {len(self.genre_df)} records to stage.Genre")

            self.hierarchy_df.to_sql(
                name="GenreHierarchy",
                con=self.engine,
                schema="stage",
                if_exists='append',
                index=False,
                dtype=self._get_column_dtypes()
            )

            logger.info(f"Successfully loaded {len(self.hierarchy_df)} records to stage.GenreHierarchy")

            return True
        except Exception as e:
            logger.error(f"Failed to load records into stage tables: {e}")
            return False

    def _get_column_dtypes(self, df: pd.DataFrame):
        """
        Map pandas dtypes to SQLAlchemy dtypes
        """
        dtype_mapping = {}

        for column in df.columns:
            col_type = df[column].dtype

            if pd.api.types.is_integer_dtype(col_type):
                dtype_mapping[column] = sqlalchemy.types.Integer()
            elif pd.api.types.is_float_dtype(col_type):
                dtype_mapping[column] = sqlalchemy.types.Float()
            elif pd.api.types.is_datetime64_dtype(col_type):
                dtype_mapping[column] = sqlalchemy.types.DateTime()
            elif pd.api.types.is_bool_dtype(col_type):
                dtype_mapping[column] = sqlalchemy.types.Boolean()
            else:
                # Default to string
                max_len = self.df[column].astype(str).str.len().max()
                dtype_mapping[column] = sqlalchemy.types.String(
                    length=int(max_len) if not pd.isna(max_len) else 255
                )
        
            return dtype_mapping

    def merge_to_final_table(self):
        """Merge data from stage table to final table"""

        try:
            genre_sql = text("""
            EXEC stage.GenreMerge
                @poInsertedRows = :inserted_rows OUTPUT
                ,@poUpdatedRows = :updated_rows OUTPUT
                ,@poDeletedRows = :deleted_rows OUTPUT
            """).bindparams(
                bindparam("inserted_rows", type_=int, outparam=True),
                bindparam("updated_rows", type_=int, outparam=True),
                bindparam("deleted_rows", type_=int, outparam=True)
            )

            hierarchy_sql = text("""
            EXEC stage.GenreHierarchyMerge
                @poInsertedRows = :inserted_rows OUTPUT
                ,@poUpdatedRows = :updated_rows OUTPUT
                ,@poDeletedRows = :deleted_rows OUTPUT
            """).bindparams(
                bindparam("inserted_rows", type_=int, outparam=True),
                bindparam("updated_rows", type_=int, outparam=True),
                bindparam("deleted_rows", type_=int, outparam=True)
            )

            with self.engine.connect() as conn:
                # Prepare params
                params = {
                    'inserted_rows': None,
                    'updated_rows': None,
                    'deleted_rows': None
                }

                # Execute Genre merge
                genre_result = conn.execute(genre_sql, params)

                # Output param is available in params dict
                logger.info(f"dbo.Genre: inserted {params['inserted_rows'] or 0} rows")
                logger.info(f"dbo.Genre: updated {params['updated_rows'] or 0} rows")
                logger.info(f"dbo.Genre: deleted {params['deleted_rows'] or 0} rows")

                # Again but for GenreHierarchy
                params = {
                    'inserted_rows': None,
                    'updated_rows': None,
                    'deleted_rows': None
                }

                # Execute Genre merge
                hierarchy_result = conn.execute(hierarchy_sql, params)

                # Output param is available in params dict
                logger.info(f"dbo.GenreHierarchy: inserted {params['inserted_rows'] or 0} rows")
                logger.info(f"dbo.GenreHierarchy: updated {params['updated_rows'] or 0} rows")
                logger.info(f"dbo.GenreHierarchy: deleted {params['deleted_rows'] or 0} rows")

                conn.commit()

    def run_etl(self, json_file_path):
        """
        Run complete ETL pipeline

        Parameters:
        - json_file_path: Path to JSON file
        """
        logger.info("Starting ETL pipeline...")

        # Step 1: Connect to DB
        if not self.connect_to_database():
            return False
        
        # Step 2: Extract JSON and load into dataframs
        if not self.extract_from_json(json_file_path):
            return False

        # Step 3: Truncate stage tables
        if not self.truncate_stage_tables():
            return False

        # Step 4: Load data into stage tables
        if not self.load_to_stage_table():
            return False

        # Step 5: Merge into final tables
        # if not self.merge_to_final_table():
        #     return False

        logger.info("Genre ETL Pipeline completed successfully!")
        return True

if __name__ == "__main__":
    # Get path to .env
    env_path = os.join(os.getcwd(), ".env")
    load_dotenv(env_path)

    DATABASE_CONNECTION_STRING = os.getenv("DATABASE_CONNECTION_STRING")

    # Get path to JSON file
    json_path = os.join(os.getcwd(), "MusicDB_ETL", "Data", "Genres.json")

    # Initialize pipeline
    etl = GenreETLPipeline(
        db_connection_string=DATABASE_CONNECTION_STRING
    )

    # Run ETL
    success = etl.run_etl(
        json_file_path=json_path
    )

    if success:
        print("ETL completed successfully!")
    else:
        print("ETL failed >:(")