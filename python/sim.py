import numpy as np
import csv
from collections import OrderedDict
from sklearn.metrics import pairwise_distances
from scipy.spatial.distance import cosine
from scipy import sparse

ratingsNames = ['userId','movieId','rating','timestamp']
ratings = np.genfromtxt('ml-20m/ratings.csv', delimiter=',', usecols=(0,1,2), names=True, dtype=[('userId','i8'),('movieId','i8'),('rating','f8')])

movieDict = OrderedDict()
userDict = OrderedDict()
for key in ratings["userId"]:
    userDict[key] = 0
for key in ratings["movieId"]:
    movieDict[key] = 0
numMovies = len(movieDict.keys())
numUsers = len(userDict.keys())

i = 0
for key in movieDict.keys():
    movieDict[key] = i
    i = i + 1
    
i = 0
for key in userDict.keys():
    userDict[key] = i
    i = i + 1

userMatrix = np.zeros(((numUsers),(numMovies)), dtype = 'f8')
for ratingRow in ratings:
    row = userDict[ratingRow[0]]
    col = movieDict[ratingRow[1]]
    rating = ratingRow[2]
    userMatrix[row,col] = rating

print(userMatrix.shape)

userMatrix = userMatrix.T
userMatrix = sparse.csr_matrix(userMatrix)

np.savez('/tmp/userMat.npz', a=userMatrix)

print("starting sim")
dist = 1 - pairwise_distances(userMatrix, metric="cosine")
print(dist.shape)

np.savez('/tmp/simMat.npz', a=dist)

data = np.load('/tmp/simMat.npz')
data = data['a']

srt = np.argsort(data)
movieList = np.array(movieDict.keys())
movieSimTop = movieList[srt[:,-101:-1]]
movieId = movieList[srt[:,-1]]

with open('topSim.csv', 'w') as fp:
    w = csv.writer(fp, delimiter=',')
    for row in range(len(movieId)):
        dataRow = np.append(np.array(movieId[row]), movieSimTop[row,:])
        w.writerow(dataRow)







        
