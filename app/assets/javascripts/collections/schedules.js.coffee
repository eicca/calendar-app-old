class App.Collections.Schedules extends Backbone.Collection
  model: App.Models.Schedule

  initialize: (options) ->
    @url = "/teachers/#{options.teacherId}/schedules/"
