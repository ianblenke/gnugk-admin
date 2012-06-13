Gnugk.Views.Eventlogs ||= {}

class Gnugk.Views.Eventlogs.IndexView extends Backbone.View
  template: JST["backbone/templates/eventlogs/index"]

  initialize: () ->
    @options.eventlogs.bind('reset', @addAll)

  addAll: () =>
    @options.eventlogs.each(@addOne)

  addOne: (eventlog) =>
    view = new Gnugk.Views.Eventlogs.EventlogView({model : eventlog})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(eventlogs: @options.eventlogs.toJSON() ))
    @addAll()

    return this
