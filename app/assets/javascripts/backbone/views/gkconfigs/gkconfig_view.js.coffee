Gnugk.Views.Gkconfigs ||= {}

class Gnugk.Views.Gkconfigs.GkconfigView extends Backbone.View
  template: JST["backbone/templates/gkconfigs/gkconfig"]

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
