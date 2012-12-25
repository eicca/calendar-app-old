class App.Models.Lesson extends Backbone.Model

  defaults:
    color: '#60A6A6'
    className: 'lessons-event'
    eventType: 'lesson'
    allDay: false

  reschedule: (data, callbacks) ->
    url = @url() + '/reschedule'
    options =
      url: url
      dataType: 'json'
      # FIXME TODO weird data passing
      data: data
      type: 'POST'

    console.log options
    _.extend options, callbacks
    (@sync or Backbone.sync).call this, null, this, options
