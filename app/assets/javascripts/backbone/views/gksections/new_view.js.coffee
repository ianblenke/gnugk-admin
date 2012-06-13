Gnugk.Views.Gksections ||= {}

class Gnugk.Views.Gksections.NewView extends Backbone.View
  template: JST["backbone/templates/gksections/new"]

  events:
    "submit #new-gksection": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (gksection) =>
        @model = gksection
        window.location.hash = "/#{@model.id}"

      error: (gksection, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
