Gnugk.Views.Gkconfigs ||= {}

class Gnugk.Views.Gkconfigs.IndexView extends Backbone.View
  template: JST["backbone/templates/gkconfigs/index"]

  initialize: () ->
    @options.gkconfigs.bind('reset', @addAll)

  addAll: () =>
    @options.gkconfigs.each(@addOne)

  addOne: (gkconfig) =>
    view = new Gnugk.Views.Gkconfigs.GkconfigView({model : gkconfig})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(gkconfigs: @options.gkconfigs.toJSON() ))
    @addAll()

    return this
