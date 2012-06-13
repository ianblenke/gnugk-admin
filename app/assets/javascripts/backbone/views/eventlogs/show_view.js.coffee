Gnugk.Views.Eventlogs ||= {}

class Gnugk.Views.Eventlogs.ShowView extends Backbone.View
  template: JST["backbone/templates/eventlogs/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
