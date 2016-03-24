
import endpoints
from protorpc import messages

class MovieList(messages.Message):
  items = messages.StringField(1, repeated=True)

class MovieRec(messages.Message):
  movieId = messages.StringField(1)

#movieId is an int
def getSimilar(movieId):
	movieIdList = ['9999', '8888', '7777', str(movieId)]
	return MovieList(items=movieIdList)

#movieId is an int
def getRec(movieId):
	return MovieRec(movieId="12345")