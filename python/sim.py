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

f = file("user_mat.bin","wb")
np.save(f,userMatrix)
f.close()

print("starting sim")
dist = 1 - pairwise_distances(userMatrix, metric="cosine")
print(dist.shape)

f = file("tmp.bin","wb")
np.save(f,dist)
f.close()


#similarity = userMatrix.dot(userMatrix.T).todense()
#square_mag = np.diag(similarity)
#inv_square_mag = 1 / square_mag
#inv_square_mag[np.isinf(inv_square_mag)] = 0
#inv_mag = np.sqrt(inv_square_mag)
#cosine = similarity * inv_mag
#cosine = cosine.T * inv_mag

#print(cosine.shape)

#f = file("tmp.bin","wb")
#np.save(f,cosine)
#f.close()
