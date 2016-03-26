
import google

class Account(ndb.Model):
  username = ndb.StringProperty()
  userid = ndb.IntegerProperty()
  email = ndb.StringProperty()

sandy = Account(username='Sandy', userid=123, email='sandy@gmail.com')

sandy_key = sandy.put()

sandy = sandy_key.get()
print(sandy)