Gnugk.Views.Gkconfigs ||= {}

class Gnugk.Views.Gkconfigs.ShowView extends Backbone.View
  template: JST["backbone/templates/gkconfigs/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
