with open('filesAll.csv') as x: f = x.readlines()
with open('allTables.csv') as x: ff = x.readlines()
slim=[]
for i in f:
	slim.append(i.split(',')[0])
for i in ff:
	if i.strip() not in slim:
		print("drop table `%s`;" %(i.strip()))
