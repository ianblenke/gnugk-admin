Gnugk.Views.Eventlogs ||= {}

class Gnugk.Views.Eventlogs.EventlogView extends Backbone.View
  template: JST["backbone/templates/eventlogs/eventlog"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html('<td>'+@model.get('created_at')+' '+@model.get('channel')+'<pre>'+JSON.stringify(@model, null, '\t')+'</pre></td>').fadeIn();

    return this
