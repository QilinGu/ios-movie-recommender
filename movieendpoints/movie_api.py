
"""/Applications/Google\ Chrome.app/Contents//MacOS/Google\ Chrome --user-data-dir=test --unsafely-treat-insecure-origin-as-secure=http://localhost:8080"""
"""http://localhost:8080/_ah/api/explorer"""
"""dev_appserver.py  helloendpoints"""

import endpoints
from protorpc import messages
from protorpc import message_types
from protorpc import remote

import similar_model as simModel

package = 'Movie'

@endpoints.api(name='movierec', version='v1')
class MovieApi(remote.Service):

  ID_RESOURCE = endpoints.ResourceContainer(message_types.VoidMessage,
      id=messages.IntegerField(1, variant=messages.Variant.INT32))

  @endpoints.method(ID_RESOURCE, simModel.MovieId,
                    path='similarMovie/{id}', http_method='GET',
                    name='movie.getSimilar')
  def similar_get(self, request):
    try:
      return simModel.getSimilar(request.id)
    except (IndexError, TypeError):
      raise endpoints.NotFoundException('Greeting %s not found.' %(request.id,))

APPLICATION = endpoints.api_server([MovieApi])



