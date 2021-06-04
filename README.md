# **IMPORTANT! We've moved development of this repo to the `main` branch. You will not be able to merge changes into `master`.**

## **UPDATING LOCAL CLONES**

(via [this link](https://www.hanselman.com/blog/EasilyRenameYourGitDefaultBranchFromMasterToMain.aspx), thanks!)

If you have a local clone, you can update and change your default branch with the steps below.

```sh
git checkout master
git branch -m master main
git fetch
git branch --unset-upstream
git branch -u origin/main
git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/main
```

The above steps accomplish:

1. Go to the master branch
2. Rename master to main locally
3. Get the latest commits from the server
4. Remove the link to origin/master
5. Add a link to origin/main
6. Update the default branch to be origin/main



# ECHO_EPA_SCRAPE_TO_MYSQL
This is a python script "scrapeECHOEPA" which makes serveral calls to the following bash scripts:
* wgetGSheet
* wgetEPA
* unzipEPA
* stripNulls
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

Preferably all of these bash scripts would be replaced by pure python, and while I found unzip modules and wget modules, they errored out when I tried them.
###
scrapeECHOEPA loads a file "currentDBIndex" to determine which is the live database (either a or b), it then scrapes and unzips the files listed in "files.csv" using the bash scripts mentioned above. 
the script gets the connection info for the currently unused database from either db_a_private.csv or db_b_private.csv, these are included as sample files that need to be populated with your database info. The user needs insert and truncate permission. 
### 
the directory "middleware" contains a short php script that relies on both currentDBIndex, and either db_a_public.csv or db_b_public.csv
the user should have select permission only. "middleware" should be moved to somewhere inside the web root of the server, the rest of the project should reside outside of web root.   
###  
dependancies that I recall are python3 php>=5.3 and wget 
###
 "schema.psql"  contains the schema for the tables listed in "files.csv" we've mostly changed the type of the columns containing indexes, I'm sure the schema could be improved. 
"schema.psql" should be loaded into your databases before "scrapeECHOEPA" is run.
 


