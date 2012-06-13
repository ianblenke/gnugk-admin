class Gnugk.Models.Eventlog extends Backbone.Model
  paramRoot: 'eventlog'

  defaults:
    data: null
    channel: null
    created_at: null

class Gnugk.Collections.EventlogsCollection extends Backbone.Collection
  model: Gnugk.Models.Eventlog
  url: '/eventlogs'
