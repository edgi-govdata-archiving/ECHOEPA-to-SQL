from sqlalchemy import create_engine
import csv
currentDBIndex=5
def connect():
    global currentDBIndex
    dbPostfixes=['a','b']
    dbTypes=['postgres','postgres']
    # dbTypes=['mysql+mysqlconnector','mysql+mysqlconnector']
    with open('currentDBIndex') as x: currentDBIndex = x.read()
    currentDBIndex=1-int(currentDBIndex)
    x.close()
    with open('db_%s_private.postgres.csv' %("b"), newline='') as csvfile:
    # with open('db_%s_private.csv' %(dbPostfixes[currentDBIndex]), newline='') as csvfile:
	    reader = csv.DictReader(csvfile)
	    for row in reader:	
		    engine = create_engine('%s://%s:%s@%s/%s' %(dbTypes[currentDBIndex],row['user'],row['password'],row['host'],row['db']),connect_args={'connect_timeout': 600000}  , echo=False)
    return engine,dbPostfixes[currentDBIndex]
def change_db():
    with open('currentDBIndex', 'w') as writer: 
        writer.write(str(currentDBIndex))