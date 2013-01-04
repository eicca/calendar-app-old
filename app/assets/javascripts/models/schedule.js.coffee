class App.Models.Schedule extends Backbone.Model

  defaults:
    className: 'schedule-event'
    eventType: 'schedule'
    allDay: false
    title: 'working hours'

  mutators:
    color: ->
      eventDate = new Date(@get('start'))
      # FIXME move to something more global
      todayDate = new Date()
      if eventDate > todayDate
        return '#9ABF49'
      else
        return '#AAA'
