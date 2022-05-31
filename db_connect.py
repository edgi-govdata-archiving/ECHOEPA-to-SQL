from sqlalchemy import create_engine
import os
import csv
import urllib.parse
currentDBIndex=5
def connect():
    global currentDBIndex
    dbPostfixes=['a','b']
    dbType='postgresql+pg8000'
    with open('currentDBIndex') as x: currentDBIndex = x.read()
    currentDBIndex=1-int(currentDBIndex)
    db='db_%s_private.csv' %dbPostfixes[currentDBIndex]
    if os.environ.get('LANDO_INFO') is None:
     dbConf='db_%s_private.postgres.csv' %dbPostfixes[currentDBIndex]
    x.close()
    with open(dbConf, newline='') as csvfile:
	    reader = csv.DictReader(csvfile)
	    for row in reader:	
		    engine = create_engine('%s://%s:%s@%s:5432/%s' %(dbType,row['user'],urllib.parse.quote_plus(row['password']),row['host'],row['db']), echo=False)
    return engine,dbPostfixes[currentDBIndex]
def change_db():
    with open('currentDBIndex', 'w') as writer: 
        writer.write(str(currentDBIndex))
