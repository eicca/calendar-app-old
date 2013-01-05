class App.Models.Lesson extends Backbone.Model

  defaults:
    className: 'lessons-event'
    eventType: 'lesson'
    allDay: false

  mutators:
    color: ->
      if @get('status') is 'completed'
        return '#aaa'
      else
        return '#60A6A6'
