
from gcloud import datastore
import numpy as np
import time

def create_client(project_id):
    return datastore.Client(project_id)

def create_task(client, key, value):
    key = client.key('similarMovieId', key)
    task = datastore.Entity(key)
    task.update(value)
    return task

simMat = np.genfromtxt('topSim.csv', delimiter=',', dtype=str)
keyList = simMat[:,0]
simMat = simMat[:,1:]

project_id = 'stately-forest-126023'
client = create_client(project_id)

"""print('starting to populate datastore')
task = create_task(client, keyList[0], {'items': list(simMat[0,:])})
client.put(task)"""

k = 0
batchKey = []
for key in keyList:
    batchKey.append(client.key('similarMovieId', key))
    k = k + 1
    if k % 100 == 0:
        while True:
            try:
                client.delete_multi(batchKey)
                batchKey = []
                print(k / float(len(keyList)))
                break 
            except:  
                print('error')  
                pass
client.delete_multi(batchKey)

k = 0
batchList = []
for movie in simMat:
    batchList.append(create_task(client, keyList[k], {'items': list(movie)}))
    k = k + 1
    if k % 100 == 0:
        while True:
            try:
                client.put_multi(batchList)
                batchList = []
                print(k / float(len(keyList)))
                break 
            except:  
                print('error')  
                pass
client.put_multi(batchList)       

"""k = 0
batchList = []
for movie in simMat:
    movieDict = {}
    i = 1
    for movieId in movie:
        movieDict[str(i)] = movieId
        i = i + 1
    batchList.append(create_task(client, keyList[k], movieDict))
    k = k + 1
    if k % 100 == 0:
        client.put_multi(batchList)
        batchList = []
        print(k / float(len(keyList)))"""


