class App.Lib.BaseCalendar extends Backbone.View

  events:
    'click .fc-button-next': 'fetchEvents'
    'click .fc-button-prev': 'fetchEvents'
    'click .fc-button-today': 'fetchEvents'

  initialize: (opts) ->
    for collection in @collections
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
      firstDay: 1
      header:
        left: 'title'
        right: 'today prev,next'
      eventAfterRender: @afterRender
      select: @select
      eventClick: @eventClick
      eventDrop: @eventDrop
      eventResize: @eventResize
    return this

  afterRender: (event, eventEl, view) ->
    $eventEl = $(eventEl)
    if event.eventType is 'schedule'
      $eventEl.width('120px')
      @afterRenderSchedule?(event, $eventEl)
    else
      $eventEl.width('105px')
      $eventEl.css('margin-left', '-43px')
      #$eventEl.children('*').css('background-color', 'red')
      @afterRenderLesson?(event, $eventEl)
    #if event.recurring
      #$('.fc-event-bg', $eventEl).css('background-color', 'green')

  renderEvents: (collection) ->
    # FIXME not sure about this way
    collection.each (item) =>
      @$el.fullCalendar('removeEvents', item.id)

    @$el.fullCalendar('addEventSource', collection.toJSON())

  fetchEvents: ->
    view = @$el.fullCalendar('getView')
    @schedules.fetch(data: {date_start: view.visStart})

  renderNewEvent: (event) ->
    @$el.fullCalendar('renderEvent', event.toJSON())

  removeEvent: (event) ->
    @$el.fullCalendar('removeEvents', event.id)

  eventResize: (event,dayDelta,minuteDelta,revertFunc) ->
    @eventDropOrResize event, revertFunc

  eventDrop: (event,dayDelta,minuteDelta,allDay,revertFunc) ->
    @eventDropOrResize event, revertFunc
