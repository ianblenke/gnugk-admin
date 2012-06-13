Gnugk.Views.Gksections ||= {}

class Gnugk.Views.Gksections.EditView extends Backbone.View
  template : JST["backbone/templates/gksections/edit"]

  events :
    "submit #edit-gksection" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (gksection) =>
        @model = gksection
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
