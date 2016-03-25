
import endpoints
from google.appengine.ext import ndb
from protorpc import messages
import protorpc

class MovieList(messages.Message):
  items = messages.StringField(1, repeated=True)

class MovieRec(messages.Message):
  movieId = messages.StringField(1)

#def lookup(client, key):
#    key = client.key('similarMovieId', key)
#    task = client.get(key)
#    result = []
#    for i in range(1, 11):
#        result.append(task[str(i)])
#    return result

#movieId is an int
#def getSimilar(movieId):
#	result = lookup(client, str(movieId))
#	return MovieList(items=result)


#movieId is an int
def getSimilar(movieId):
  movieIdList = ['9999', '8888', '7777', str(movieId)]
  return MovieList(items=movieIdList)



#movieId is an int
def getRec(movieId):
	return MovieRec(movieId="12345")
