class Gnugk.Routers.GksectionsRouter extends Backbone.Router
  initialize: (options) ->
    @gksections = new Gnugk.Collections.GksectionsCollection()
    @gksections.reset options.gksections

  routes:
    "new"      : "newGksection"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGksection: ->
    @view = new Gnugk.Views.Gksections.NewView(collection: @gksections)
    $("#gksections").html(@view.render().el)

  index: ->
    @view = new Gnugk.Views.Gksections.IndexView(gksections: @gksections)
    $("#gksections").html(@view.render().el)

  show: (id) ->
    gksection = @gksections.get(id)

    @view = new Gnugk.Views.Gksections.ShowView(model: gksection)
    $("#gksections").html(@view.render().el)

  edit: (id) ->
    gksection = @gksections.get(id)

    @view = new Gnugk.Views.Gksections.EditView(model: gksection)
    $("#gksections").html(@view.render().el)
