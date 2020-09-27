import csv
numNULLs=0
with open('ECHO_EXPORTER.csv', newline='') as csvfile:
	reader = csv.DictReader(csvfile)
	for row in reader:
		if row['REGISTRY_ID']=="":
			numNULLs+=1
		else:
			print(row['REGISTRY_ID'])
print(numNULLs)
