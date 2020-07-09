from sqlalchemy import create_engine
import csv
def connect():
    dbPostfixes=['a','b']
    dbTypes=['mysql+mysqlconnector','postgres']
    #dbTypes=['mysql+mysqlconnector','mysql+mysqlconnector']
    with open('currentDBIndex') as x: currentDBIndex = x.read()
    currentDBIndex=1-int(currentDBIndex)
    x.close()
    currentDBIndex=1
    with open('db_%s_private.postgres.csv' %(dbPostfixes[currentDBIndex]), newline='') as csvfile:
	    reader = csv.DictReader(csvfile)
	    for row in reader:	
		    engine = create_engine('%s://%s:%s@%s/%s' %(dbTypes[currentDBIndex],row['user'],row['password'],row['host'],row['db']), echo=False)
    return engine
