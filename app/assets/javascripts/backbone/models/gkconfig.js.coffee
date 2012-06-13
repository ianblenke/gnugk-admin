class Gnugk.Models.Gkconfig extends Backbone.Model
  paramRoot: 'gkconfig'

  defaults:
    section: null
    key: null
    value: null

class Gnugk.Collections.GkconfigsCollection extends Backbone.Collection
  model: Gnugk.Models.Gkconfig
  url: '/gkconfigs'
