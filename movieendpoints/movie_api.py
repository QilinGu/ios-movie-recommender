
"""/Applications/Google\ Chrome.app/Contents//MacOS/Google\ Chrome --user-data-dir=test --unsafely-treat-insecure-origin-as-secure=http://localhost:8080"""
"""http://localhost:8080/_ah/api/explorer"""
"""dev_appserver.py  helloendpoints"""

import endpoints
from protorpc import messages
from protorpc import message_types
from protorpc import remote

package = 'Movie'

class MovieId(messages.Message):
  items = messages.StringField(1, repeated=True)


strLst = [  'hello world!', 'goodbye world!',]
collection =  MovieId(items=strLst)

@endpoints.api(name='movierec', version='v1')
class MovieApi(remote.Service):

  ID_RESOURCE = endpoints.ResourceContainer(message_types.VoidMessage,
      id=messages.IntegerField(1, variant=messages.Variant.INT32))

  @endpoints.method(ID_RESOURCE, MovieId,
                    path='similarMovie/{id}', http_method='GET',
                    name='movie.getSimilar')
  def similar_get(self, request):
    try:
      return collection
    except (IndexError, TypeError):
      raise endpoints.NotFoundException('Greeting %s not found.' %(request.id,))

APPLICATION = endpoints.api_server([MovieApi])



