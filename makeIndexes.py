#!/usr/bin/env python3
import csv
import os
import sys
import pandas as pd
import mysql.connector
import glob
from sqlalchemy import create_engine
os.chdir(os.path.dirname(sys.argv[0]))
dbPostfixes=['a','b']
dbTypes=['mysql+mysqlconnector','postgres']
#dbTypes=['mysql+mysqlconnector','mysql+mysqlconnector']
with open('currentDBIndex') as x: currentDBIndex = x.read()
currentDBIndex=1-int(currentDBIndex)
x.close()
with open('db_%s_private.csv' %(dbPostfixes[currentDBIndex]), newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
                engine = create_engine('%s://%s:%s@%s/%s' %(dbTypes[currentDBIndex],row['user'],row['password'],row['host'],row['db']), echo=False)
con=engine.connect()

with open('indexes.csv', newline='') as csvfile:
	reader = csv.DictReader(csvfile)
	for row in reader:
		#with engine.connect() as con:
		try:
			rs = con.execute('create index %s on "%s" ("%s")' %(row["name"],row["table"],row["column"]))
			print('created index %s on "%s" ("%s")' %(row["name"],row["table"],row["column"])) 
		except Exception as e:
			print (e.__class__.__name__)
			print('cannot create index %s on "%s" ("%s")' %(row["name"],row["table"],row["column"])) 
