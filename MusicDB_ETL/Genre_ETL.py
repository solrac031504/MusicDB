# Loads the Genre and GenreHierarchy tables from a JSON file
import json
import os

# Get file path
jsonPath = os.path.join(os.getcwd(), "MusicDB_ETL", "Data", "Genres.json")

# Load JSON from file
with open(jsonPath, 'r') as file:
    genres = json.load(file)

print(genres)