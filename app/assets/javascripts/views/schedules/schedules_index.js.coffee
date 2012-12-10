class App.Views.SchedulesIndex extends Backbone.View

  initialize: (@opts) ->
    _(this).bindAll()
    @schedules = new App.Collections.Schedules(teacherId: @opts.teacherId)
    @lessons = new App.Collections.Lessons(teacherId: @opts.teacherId)

    for collection in [@schedules, @lessons]
      collection.on 'reset', @renderEvents, collection
      collection.fetch()

  render: ->
    @$el.fullCalendar
      events: []
      defaultView: 'agendaWeek'
      editable: true
      minTime: '7:00' # start of the working day
      maxTime: '20:00' # end of the working day
      allDaySlot: false
      allDayDefault: false
      selectable: true
      selectHelper: true
      header:
        left: 'title'
        center: 'agendaWeek, month'
        right: 'today prev,next'
      select: @select
    return this

  select: (startDate, endDate) ->
    view = new App.Views.Schedule()
    view.render()

  renderEvents: (collection) ->
    @$el.resize() # FIXME boilerplate
    #@$el.fullCalendar('removeEvents')
    @$el.fullCalendar('addEventSource', collection.toJSON())
