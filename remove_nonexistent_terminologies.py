import csv
import os

terminology_list = os.listdir('./terminologies')

csv_rows = []
with open('processedTerminologies.csv', 'r', newline='') as csvfile:
    reader = csv.DictReader(csvfile, delimiter=',')
    # preserve fieldnames for writing
    fieldnames = reader.fieldnames
    for one_row in reader:
        if one_row['name'] and one_row['name'] in terminology_list:
            csv_rows.append(one_row)
        else:
            print('Terminology not contained in ./terminologies: ' + one_row['name'])

print('---------Existing Terminologies---------')
print(csv_rows)

with open('processedTerminologies.csv', 'w', newline='') as csvfile:
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames, delimiter=',')

    writer.writeheader()
    for one_row in csv_rows:
        writer.writerow(one_row)