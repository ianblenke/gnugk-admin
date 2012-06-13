Gnugk.Views.Gkconfigs ||= {}

class Gnugk.Views.Gkconfigs.EditView extends Backbone.View
  template : JST["backbone/templates/gkconfigs/edit"]

  events :
    "submit #edit-gkconfig" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (gkconfig) =>
        @model = gkconfig
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
