from gcloud import datastore
import numpy as np
from collections import OrderedDict
import time, sys

def create_client(project_id):
    return datastore.Client(project_id)

def create_task(client, key, value):
    key = client.key('UserRatings', key)
    task = datastore.Entity(key)
    task.update(value)
    return task

project_id = 'stately-forest-126023'
client = create_client(project_id)

ratingsNames = ['userId','movieId','rating','timestamp']
ratings = np.genfromtxt('ml-20m/ratings.csv', delimiter=',', 
	usecols=(0,1,2), names=True, dtype=[('userId','i8'),('movieId','i8'),('rating','f8')])

k = 0
batchList = []
for row in ratings:
    batchList.append(create_task(client, str(row['userId']), {str(row['movieId']): str(row['rating'])}))
    k = k + 1
    if k % 499 == 0:
        while True:
            try:
                client.put_multi(batchList)
                batchList = []
                print(k / float(ratings.shape[0]))
                break 
            except:  
                print('error: {0}'.format(sys.exc_info()[0])) 
                time.sleep(5)  
                pass
client.put_multi(batchList)  





