Gnugk.Views.Gksections ||= {}

class Gnugk.Views.Gksections.ShowView extends Backbone.View
  template: JST["backbone/templates/gksections/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
