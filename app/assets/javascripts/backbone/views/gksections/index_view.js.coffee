Gnugk.Views.Gksections ||= {}

class Gnugk.Views.Gksections.IndexView extends Backbone.View
  template: JST["backbone/templates/gksections/index"]

  initialize: () ->
    @options.gksections.bind('reset', @addAll)

  addAll: () =>
    @options.gksections.each(@addOne)

  addOne: (gksection) =>
    view = new Gnugk.Views.Gksections.GksectionView({model : gksection})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(gksections: @options.gksections.toJSON() ))
    @addAll()

    return this
