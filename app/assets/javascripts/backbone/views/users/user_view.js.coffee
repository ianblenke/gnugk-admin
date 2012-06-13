Gnugk.Views.Users ||= {}

class Gnugk.Views.Users.UserView extends Backbone.View
  template: JST["backbone/templates/users/user"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if confirm('Are you sure you want to delete this user?')
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
