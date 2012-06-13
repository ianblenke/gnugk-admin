Gnugk.Views.Users ||= {}

class Gnugk.Views.Users.IndexView extends Backbone.View
  template: JST["backbone/templates/users/index"]

  initialize: () ->
    console.log JSON.stringify(@options)
    @options.users.bind('reset', @addAll)

  addAll: () =>
    @options.users.each(@addOne)

  addOne: (user) =>
    view = new Gnugk.Views.Users.UserView({model : user})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(users: @options.users.toJSON() ))
    @addAll()

    return this
