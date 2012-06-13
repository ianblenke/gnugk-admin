Gnugk.Views.Users ||= {}

class Gnugk.Views.Users.ShowView extends Backbone.View
  template: JST["backbone/templates/users/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
