import csv
import os
from pathlib import Path
from google_play_scraper import search

# Step 1: Request search query from user at runtime
search_query = input("Enter the Play Store search keyword: ").strip()
if not search_query:
    print("Search query cannot be empty. Exiting.")
    exit()

num_results = 50  # Number of apps to fetch

print(f"\nSearching for '{search_query}'")
app_results = search(search_query, lang="en", country="us")

# Limit results to the requested count
apps_to_save = app_results[:num_results]

if not apps_to_save:
    print("No apps found for this search term.")
    exit()

# Step 2: The download path is currently set as the current directory
downloads_folder = "."
appid_path = os.path.join(downloads_folder, "appid.csv")
appdetails_path = os.path.join(downloads_folder, "appdetails.csv")

# Step 3: Write 'appid.csv' (Contains ONLY app ids, no header, no other columns)
with open(appid_path, "w", newline="", encoding="utf-8") as id_file:
    writer = csv.writer(id_file)
    for app in apps_to_save:
        writer.writerow([app["appId"]])

# Step 4: Write 'appdetails.csv' (Contains appid, title, developer, and score/downloads placeholder)
with open(appdetails_path, "w", newline="", encoding="utf-8") as details_file:
    fieldnames = ["appid", "title", "developer", "rating"]
    writer = csv.DictWriter(details_file, fieldnames=fieldnames)
    
    writer.writeheader()
    for app in apps_to_save:
        writer.writerow({
            "appid": app["appId"],
            "title": app["title"],
            "developer": app.get("developer", "N/A"),
            "rating": app.get("score", "N/A")  
        })

print("\nExtraction Complete!")
print(f" Saved app IDs to: {appid_path}")
print(f" Saved details to: {appdetails_path}")

