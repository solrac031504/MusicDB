# Loads the Genre and GenreHierarchy tables from a JSON file
import json
import os

# Get file path
json_path = os.path.join(os.getcwd(), "MusicDB_ETL", "Data", "Genres.json")

# Load JSON from file
with open(json_path, 'r') as file:
    genres = json.load(file)

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

"""
Script entry point
"""
def main(args=None):
    for outer_key, outer_val in genres.items():
        traverse_tree(outer_val, child=outer_key)
        get_or_create_genre_id(outer_key)
        # If no parents, add -1 parent entry
        if outer_val is None:
            add_relationship(outer_key, -1)

if __name__ == "__main__":
    main()

    print("Raw Genres")
    print(genre_rows)

    print("Genre Hierarchy")
    print(relationship_rows)