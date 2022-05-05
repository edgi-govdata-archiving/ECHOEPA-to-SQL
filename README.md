# ECHO_EPA_SCRAPE_TO_MYSQL
This is a Python script "scrapeECHOEPA" which makes several calls to the following bash scripts:
* wgetGSheet
* wgetEPA
* unzipEPA
* stripNulls
* createTable
###
These are all helper scripts which do not need to be run independantly. 
All of the above require execute permission (chmod u+x <filename>)
###

wgetGsheet downloads the Google Sheet here:
https://docs.google.com/spreadsheets/d/1Z2rBoGqb_SXW6oAu12A6TCWEJGV1pk0YxL13P_Z5Wlw/export?format=csv&gid=2049992364
and saves it to "files.csv"
###

###
wgetEPA will get zip files file from the ECHO EPA website and place it in a directory "zips"
###
unzipEPA takes a file located in "zips" and extracts it to a directory "CSV"
###
stripNulls strips the nulls from some of the CSVs files which would fail to import otherwise

Preferably all of these bash scripts would be replaced by pure python.
###
scrapeECHOEPA loads a file "currentDBIndex" to determine which is the live database (either a or b), it then scrapes and unzips the files listed in "files.csv" using the bash scripts mentioned above. 
the script gets the connection info for the currently unused database from either db_a_private.csv or db_b_private.csv, these are included as sample files that need to be populated with your database info. The user needs insert and truncate permission. 
### 
the directory "middleware" contains a short php script that relies on both currentDBIndex, and either db_a_public.csv or db_b_public.csv
the user should have select permission only. "middleware" should be moved to somewhere inside the web root of the server, the rest of the project should reside outside of web root.   
###  
dependencies are python3, php>=5.3, csvkit, and wget 
###
"schema.psql"  contains the schema for the tables listed in "files.csv"
"schema.psql" should be loaded into your databases before "scrapeECHOEPA" is run.

## Set-up
-   Install Docker/Lando (in some cases, as with Mac, Lando installation includes Docker...)
-   Clone this GH repo  `git clone` `[https://github.com/edgi-govdata-archiving/ECHOEPA-to-SQL](https://github.com/edgi-govdata-archiving/ECHOEPA-to-SQL)`
-   `cd ECHOEPA-to-SQL`
-   `lando start`
	-   Errors:
		-  `psql: connection to server at "database" (172.22.0.3), port 5432 failed: FATAL: database "slim_echoepa" does not exist`
		-   `ERROR ==> psql: connection to server at "database" (172.22.0.3), port 5432 failed: FATAL: database "slim_echoepa" does not exist`
	-   Fixed with
		-   `- psql -U postgres -h database -c "CREATE DATABASE slim_echoepa;"`
		-   `- psql -U postgres -h database -c "CREATE USER echoepa WITH ENCRYPTED PASSWORD '***';"`
		-   `- psql -U postgres -h database -c "CREATE USER echoepa_public WITH ENCRYPTED PASSWORD '***';"`
		-   (probably could just remove the "ALTER" commands too)
	-   `:q`  to quit vim in the middle of installation
	-   May get a warning at the end but this is an expected Apache warning
-   Get EPA data!
	-   `lando ssh --user root`
	-   `pip install csvkit`
	-   get the most current list of files for scraping (optional, but you may want to edit this list especially for testing to avoid downloading too much data)
		-   `./wgetGSheet` (may need permissions here)
	-   Scrape EPA and get the data
		-   Set permissions
			-   `chmod +x scrapeECHOEPA`
			-   `chmod +x wgetEPA`
			-   `chmod +x stripNulls`
			-   `chmod +x unzipEPA`
			-   `chmod +x createTable`
			-   etc.
		-	Set up spatial data:
			-	Install postgis the following way, first on DB.
				-	`lando ssh -s database --user root`
				-	`apt-get update`
				-	`apt-get install postgis`
			-	We then need to run CREATE_EXTENSION postgis in postgres. 
				-	`psql -d slim_echoepa -U echoepa`
				-	`CREATE_EXTENSION postgres`
			-	Then on app server (for downloading and add shapefiles to the DB).
				-	Same process as above on DB
		-   Finally, run `./scrapeECHOEPA`
-   Duplicate and rename db parameter files
	-   db_a_private.postgres.csv
	-   db_b_private.postgres.csv
-	Troubleshoot
	- 	access DB psql with normal permissions `lando psql -d slim_echoepa -U echoepa`
	-	access DB app (postgres user has better access?) `lando ssh -s database --user root` \ `lando ssh -s database --user postgres`
-	To dump schema
	- `lando ssh -s database --user postgres`
	- `pg_dump -s slim_echoepa > schema.psql`
-	To drop schema and rebuild
	- `lando psql -d slim_echoepa -U postgres`
	- psql `DROP SCHEMA public CASCADE;`
	- `CREATE SCHEMA public;`
	- `GRANT ALL ON SCHEMA public TO postgres;`
	- `GRANT ALL ON SCHEMA public TO public;`
	- `exit`
	- `lando ssh -s database --user postgres`
	- `psql -f test_schema.psql -U postgres slim_echoepa`
- 	Load views schema
	- `lando ssh -s database --user postgres`
	- `psql -h database -d slim_echoepa -U echoepa -f views.psql`

- 	Need to grant privlieges before you can analyze
	- `GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO echoepa_public;`
- 	Test query
	-   go to the lando local host in your browser `landoechoepa.lndo.site`
- 	Analyze!
	-   clone EDGI Notebook repos, especially [ECHO_modules](https://github.com/edgi-govdata-archiving/ECHO_modules)
	-   be sure to replace  `url= [http://portal.gss.stonybrook.edu/echoepa/?query=](http://portal.gss.stonybrook.edu/echoepa/?query=)`  with  `url = [https://landoechoepa.lndo.site/?query=](https://landoechoepa.lndo.site/?query=)`

# Irregularities
Things holding up automatic data copying and requiring alterations
- 	Test spatial data, may not have loaded into db properly
