
import endpoints
from protorpc import messages

class MovieId(messages.Message):
  items = messages.StringField(1, repeated=True)

#movieId is an int
def getSimilar(movieId):
	movieIdList = ['9999', '8888', '7777', str(movieId)]
	return MovieId(items=movieIdList)