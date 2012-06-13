Gnugk.Views.Gkconfigs ||= {}

class Gnugk.Views.Gkconfigs.NewView extends Backbone.View
  template: JST["backbone/templates/gkconfigs/new"]

  events:
    "submit #new-gkconfig": "save"

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
      success: (gkconfig) =>
        @model = gkconfig
        window.location.hash = "/#{@model.id}"

      error: (gkconfig, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
