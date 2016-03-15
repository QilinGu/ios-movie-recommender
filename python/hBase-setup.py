import happybase
import numpy as np
from collections import OrderedDict

# hbase-daemon.sh start thrift

connection = happybase.Connection('ec2-52-91-124-190.compute-1.amazonaws.com', autoconnect=False)
connection.open()

print("creating table")
tableName = 'userByMovie'
#connection.disable_table(tableName)
#connection.delete_table(tableName)
connection.create_table(tableName, {'cf1': dict()})

table = connection.table(tableName)

print("starting load data")
ratings = np.genfromtxt('ml-20m/ratings.csv', delimiter=',', usecols=(0,1,2), names=True, dtype=[('userId','i8'),('movieId','i8'),('rating','f8')])

print("starting batch")
b = table.batch()
i = 0
for row in ratings:
    valDict = {}
    col = "cf1:{0}".format(row['movieId'])
    valDict[col] = str(row['rating'])
    b.put(str(row['userId']), valDict)
    if i % 10000 == 0:
        b.send()
        b = table.batch()
    print("{0} rows added".format(i))
    i = i + 1
print("sending batch")
b.send()

print connection.tables()
print("done")
