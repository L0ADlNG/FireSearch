# FireSearch
Download apk files. Dump firebase databases from the apk files.

git clone https://github.com/L0ADlNG/FireSearch.git

1. run.sh includes both downloading apk files and database finding options. It uses fire.sh for finding databases.
2. Run fire.sh if you only want to find databases within apk files located in the same directory.

run.sh creates a list of app IDs using createcsv.py, then downloads all the apk files using the csv file through ApkPure.
fire.sh looks for firebase URLs within the apk files and attaches /.json at the end of the URL. This is the URL that potentially displays all the contents of the database.
