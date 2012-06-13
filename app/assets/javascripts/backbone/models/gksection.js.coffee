class Gnugk.Models.Gksection extends Backbone.Model
  paramRoot: 'gksection'

  defaults:
    name: null

class Gnugk.Collections.GksectionsCollection extends Backbone.Collection
  model: Gnugk.Models.Gksection
  url: '/gksections'
