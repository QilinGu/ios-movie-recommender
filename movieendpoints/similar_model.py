
import endpoints
from google.appengine.ext import ndb
from protorpc import messages
import protorpc

class MovieList(messages.Message):
	items = messages.StringField(1, repeated=True)

class MovieRec(messages.Message):
	movieId = messages.StringField(1)

class similarMovieId(ndb.Model):
	items = ndb.StringProperty(repeated = True)

#movieId is an int
def getSimilar(movieId):
	test_key = ndb.Key(similarMovieId, str(movieId))
	return MovieList(items=test_key.get().items)

#movieId is an int
def getRec(movieId):
	return MovieRec(movieId='5')

