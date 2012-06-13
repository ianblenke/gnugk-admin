class Gnugk.Routers.UsersRouter extends Backbone.Router
  initialize: (options) ->
    @users = new Gnugk.Collections.UsersCollection()
    @users.reset options.users

  routes:
    "new"      : "newUser"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newUser: ->
    @view = new Gnugk.Views.Users.NewView(collection: @users)
    $("#users").html(@view.render().el)

  index: ->
    @view = new Gnugk.Views.Users.IndexView(users: @users)
    $("#users").html(@view.render().el)

  show: (id) ->
    user = @users.get(id)

    @view = new Gnugk.Views.Users.ShowView(model: user)
    $("#users").html(@view.render().el)

  edit: (id) ->
    user = @users.get(id)

    @view = new Gnugk.Views.Users.EditView(model: user)
    $("#users").html(@view.render().el)
