
import endpoints
from google.appengine.ext import ndb
from protorpc import messages
import protorpc

class MovieList(messages.Message):
	items = messages.StringField(1, repeated=True)

class MovieRec(messages.Message):
	movieId = messages.StringField(1)

class Account(ndb.Model):
  username = ndb.StringProperty()
  userid = ndb.IntegerProperty()
  email = ndb.StringProperty()
  tags = ndb.StringProperty(repeated = True)

class similarMovieId(ndb.Model):
  username = ndb.StringProperty()

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
	tagsList = ['test1', 'test2', 'test3', 'test4']
	sandy = Account(username='Sandy', userid=123, email='sandy@gmail.com', tags = tagsList, id="12345")
	sandy_key = sandy.put()
	res = sandy_key.get()
	print(res)
	print(res.tags)

	#test_key = ndb.Key(similarMovieId, '1')
	#print(test_key.get())

	movieIdList = ['9999', '8888', '7777', str(movieId)]
	return MovieList(items=movieIdList)

#movieId is an int
def getRec(movieId):
	return MovieRec(movieId="12345")




