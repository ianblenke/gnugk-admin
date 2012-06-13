Gnugk.Views.Gksections ||= {}

class Gnugk.Views.Gksections.GksectionView extends Backbone.View
  template: JST["backbone/templates/gksections/gksection"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
