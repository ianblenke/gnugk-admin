class Gnugk.Routers.EventlogsRouter extends Backbone.Router
  initialize: (options) ->
    @eventlogs = new Gnugk.Collections.EventlogsCollection()
    @eventlogs.reset options.eventlogs

  routes:
    "index"    : "index"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    @view = new Gnugk.Views.Eventlogs.IndexView(eventlogs: @eventlogs)
    $("#eventlogs").html(@view.render().el)

  show: (id) ->
    eventlog = @eventlogs.get(id)

    @view = new Gnugk.Views.Eventlogs.ShowView(model: eventlog)
    $("#eventlogs").html(@view.render().el)

