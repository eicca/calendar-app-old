class App.Views.SchedulesIndex extends Backbone.View

  events:
    'click .fc-button-next': 'fetchEvents'
    'click .fc-button-prev': 'fetchEvents'

  initialize: (opts) ->
    _(this).bindAll()
    @schedules = opts.schedules
    @lessons = new App.Collections.Lessons(teacherId: 1)

    for collection in [@schedules, @lessons]
      collection.on 'reset', @renderEvents, collection
      collection.on 'item:created', @renderNewEvent
      collection.on 'destroy', @removeEvent

  render: ->
    @$el.fullCalendar
      defaultView: 'agendaWeek'
      editable: true
      #minTime: '7:00' # start of the working day
      #maxTime: '20:00' # end of the working day
      allDaySlot: false
      allDayDefault: false
      selectable: true
      selectHelper: true
      header:
        left: 'title'
        right: 'today prev,next'
      eventAfterRender: @afterRender
      select: @select
      eventClick: @eventClick
      eventDrop: @eventDrop
      eventResize: @eventResize

    @renderEvents(@schedules)
    #@schedules.fetch(data: {date_from: view.visStart, date_until: view.visEnd})

    return this

  afterRender: (event, eventEl, view) ->
    $eventEl = $(eventEl)
    if event.recurring
      $('.fc-event-bg', $eventEl).css('background-color', 'green')

  select: (startDate, endDate) ->
    attrs = title: 't', start_at: startDate, end_at: endDate
    view = new App.Views.ScheduleNew(attrs, @schedules)
    view.render()

  eventClick: (event) ->
    model = @schedules.get(event.id)
    view = new App.Views.ScheduleEdit(model)
    view.render()

  renderEvents: (collection) ->
    @$el.fullCalendar('removeEvents')
    @$el.fullCalendar('addEventSource', collection.toJSON())

  fetchEvents: ->
    view = @$el.fullCalendar('getView')
    @schedules.fetch(data: {date_start: view.visStart, date_end: view.visEnd})

  renderNewEvent: (event) ->
    @$el.fullCalendar('renderEvent', event.toJSON())

  removeEvent: (event) ->
    @$el.fullCalendar('removeEvents', event.id)

  eventResize: (event,dayDelta,minuteDelta,revertFunc) ->
    @eventDropOrResize event, revertFunc

  eventDrop: (event,dayDelta,minuteDelta,allDay,revertFunc) ->
    @eventDropOrResize event, revertFunc

  eventDropOrResize: (event, revert) ->
    @schedules.get(event.id).save(schedule: {start_at: event.start, end_at: event.end},
    error: (data, response) ->
      revert()
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert("#{attribute} - #{message}") for message in messages
    )
