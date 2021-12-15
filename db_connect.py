from sqlalchemy import create_engine
import csv
currentDBIndex=0
dbType='postgresql'

def connect():
    global currentDBIndex
    dbPostfixes=['a','b']
    with open('currentDBIndex') as x: currentDBIndex = x.read()
    currentDBIndex=1-int(currentDBIndex)
    x.close()

    with open('db_%s_private.csv' %(dbPostfixes[currentDBIndex]), newline='') as csvfile:
	    reader = csv.DictReader(csvfile)
	    for row in reader:	
		    engine = create_engine('%s://%s:%s@%s/%s' %(dbType,row['user'],row['password'],row['host'],row['db']),pool_recycle=3600,connect_args={'connect_timeout': 600000}  , echo=False)
    return engine,dbPostfixes[currentDBIndex]
def change_db():
    with open('currentDBIndex', 'w') as writer: 
        writer.write(str(currentDBIndex))
