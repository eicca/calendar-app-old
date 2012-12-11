class App.Views.SchedulesIndex extends Backbone.View

  initialize: (@opts) ->
    _(this).bindAll()
    @schedules = new App.Collections.Schedules(teacherId: @opts.teacherId)
    @lessons = new App.Collections.Lessons(teacherId: @opts.teacherId)

    for collection in [@schedules, @lessons]
      collection.on 'reset', @renderEvents, collection
      collection.on 'item:created', @renderNewEvent
      collection.on 'destroy', @removeEvent
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
      eventClick: @eventClick
      eventDrop: @eventDrop
      eventResize: @eventResize

    return this

  select: (startDate, endDate) ->
    attrs = title: 't', start_at: startDate, end_at: endDate
    view = new App.Views.ScheduleNew(attrs, @schedules)
    view.render()

  eventClick: (event) ->
    model = @schedules.get(event.id)
    view = new App.Views.ScheduleEdit(model)
    view.render()

  renderEvents: (collection) ->
    @$el.resize() # FIXME boilerplate
    #@$el.fullCalendar('removeEvents')
    @$el.fullCalendar('addEventSource', collection.toJSON())

  renderNewEvent: (event) ->
    @$el.fullCalendar('renderEvent', event.toJSON())

  removeEvent: (event) ->
    @$el.fullCalendar('removeEvents', event.id)

  eventResize: (event,dayDelta,minuteDelta,revertFunc) ->
    @eventDropOrResize event, revertFunc

  eventDrop: (event,dayDelta,minuteDelta,allDay,revertFunc) ->
    @eventDropOrResize event, revertFunc

  eventDropOrResize: (event, revert) ->
    @schedules.get(event.id).save({title: 't', start_at: event.start, end_at: event.end},
    error: (data) ->
      revert()
      alert data.responseText
    )
