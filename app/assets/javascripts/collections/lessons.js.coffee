class App.Collections.Lessons extends Backbone.Collection
  model: App.Models.Lesson
  url: '/lessons'

  initialize: (@opts) ->

