# ECHO_EPA_SCRAPE_TO_MYSQL
This is a python script "scrapeECHOEPA" which makes serveral calls to the following bash scripts:
* wgetEPA
* unzipEPA
* stripNulls
* chunkFile
###
These are all helper scripts which do not need to be run independantly. 
All of the above require execute permission (chmod u+x <filename>)
###
wgetEPA will get a zip file from the ECHO EPA website and place it in a directory "zips"
###
unzipEPA takes a file located in "zips" and extracts it to a directory "CSV"
###
stripNulls strips the nulls from one of the CSVs (CASE_ENFORCEMENTS) which would cause panda's to_sql to fail otherwise
###
chunkFile takes the larger csv file and creates multiple smaller csv file for correct import using panda's to_sql
###
Preferably all of these bash scripts would be replaced by pure python, and while I found unzip modules and wget modules, they errored out when I tried them.
###
scrapeECHOEPA loads a file "currentDBIndex" to determine which is the live database (either a or b), it then scrapes and unzips the files listed in "files.csv" using the bash scripts mentioned above. 
the script gets the connection info for the currently unused database from either db_a_private.csv or db_b_private.csv, these are included as sample files that need to be populated with your database info. The user needs insert and truncate permission. 
### 
the directory "middleware" contains a short php script that relies on both currentDBIndex, and either db_a_public.csv or db_b_public.csv
the user should have select permission only. "middleware" should be moved to somewhere inside the web root of the server, the rest of the project should reside outside of wen root.   
###  
dependancies that I recall are python3 php>=5.3 wget and [Parallel](https://www.gnu.org/software/parallel/) used by "chunkFile"
###
 "schema.sql"  contains the schema for the tables listed in "files.csv" we've mostly changed the type of the columns containing indexes, I'm sure the schema could be improved. 
"schema.sql" should be loaded into your databases before "scrapeECHOEPA" is run.
 


