class Gnugk.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    username: null
    password: null
    firstname: null
    lastname: null

class Gnugk.Collections.UsersCollection extends Backbone.Collection
  model: Gnugk.Models.User
  url: '/users'
