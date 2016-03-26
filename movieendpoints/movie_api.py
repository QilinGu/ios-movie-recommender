
"""/Applications/Google\ Chrome.app/Contents//MacOS/Google\ Chrome --user-data-dir=test --unsafely-treat-insecure-origin-as-secure=http://localhost:8080"""
"""http://localhost:8080/_ah/api/explorer"""
"""dev_appserver.py  helloendpoints"""
"""appcfg.py update helloendpoints"""
"""https://stately-forest-126023.appspot.com/_ah/api/movierec/v1/similarMovie/5"""
"""https://stately-forest-126023.appspot.com/_ah/api/movierec/v1/movieRec/5"""
"""source venv/bin/activate"""

import endpoints
from protorpc import messages
from protorpc import message_types
from protorpc import remote

import similar_model as simModel

package = 'Movie'

@endpoints.api(name='movierec', version='v1')
class MovieApi(remote.Service):

  ID_RESOURCE = endpoints.ResourceContainer(message_types.VoidMessage,
      id=messages.IntegerField(1, variant=messages.Variant.INT32, required=True))

  @endpoints.method(ID_RESOURCE, simModel.MovieList,
                    path='similarMovie/{id}', http_method='GET',
                    name='movie.getSimilar')
  def similar_get(self, request):
    try:
      return simModel.getSimilar(request.id)
    except:
      raise endpoints.NotFoundException('%s not found.' %(request.id,))

  @endpoints.method(ID_RESOURCE, simModel.MovieRec,
                    path='movieRec/{id}', http_method='GET',
                    name='movie.getRec')
  def rec_get(self, request):
    try:
      return simModel.getRec(request.id)
    except:
      raise endpoints.NotFoundException('%s not found.' %(request.id,))

APPLICATION = endpoints.api_server([MovieApi])



