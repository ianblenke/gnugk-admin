class Gnugk.Routers.GkconfigsRouter extends Backbone.Router
  initialize: (options) ->
    @gkconfigs = new Gnugk.Collections.GkconfigsCollection()
    @gkconfigs.reset options.gkconfigs

  routes:
    "new"      : "newGkconfig"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newGkconfig: ->
    @view = new Gnugk.Views.Gkconfigs.NewView(collection: @gkconfigs)
    $("#gkconfigs").html(@view.render().el)

  index: ->
    @view = new Gnugk.Views.Gkconfigs.IndexView(gkconfigs: @gkconfigs)
    $("#gkconfigs").html(@view.render().el)

  show: (id) ->
    gkconfig = @gkconfigs.get(id)

    @view = new Gnugk.Views.Gkconfigs.ShowView(model: gkconfig)
    $("#gkconfigs").html(@view.render().el)

  edit: (id) ->
    gkconfig = @gkconfigs.get(id)

    @view = new Gnugk.Views.Gkconfigs.EditView(model: gkconfig)
    $("#gkconfigs").html(@view.render().el)
