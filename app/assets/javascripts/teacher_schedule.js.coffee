$ ->
  calendar = $('#teacher-schedule')

  teacherId = calendar.data('teacher-id')
  scheduleUrl = "/teachers/#{teacherId}/schedules"
  lessonsUrl = "/lessons"

  calendar.fullCalendar
    defaultView: 'agendaWeek'
    eventSources: [
      {
        url: scheduleUrl
      },
      {
        url: lessonsUrl
      }
    ]
    editable: true
    minTime: '7:00' # start of the working day
    maxTime: '20:00' # end of the working day
    allDaySlot: false
    allDayDefault: false
    selectable: true

    header:
      left: 'title'
      center: 'agendaWeek, month'
      right: 'today prev,next'

    #dayClick: (date, allDay, jsEvent, view) ->
      #return if view.name != 'agendaWeek'
      #endDate = new Date(date)
      #endDate.setHours(endDate.getHours() + 1)
      #createEvent(date, endDate)

    select: (startDate, endDate, allDay, jsEvent, view) ->
      return if view.name != 'agendaWeek'
      createEvent(startDate, endDate)

    selectHelper: true

    eventResize: (event) ->
      sendUpdate event
    eventDrop: (event) ->
      sendUpdate event

    eventClick: (event) ->
      $.ajax
        type: 'DELETE'
        url: scheduleUrl + "/#{event.id}"
        dataType: 'json'
        success: ->
          calendar.fullCalendar('removeEvents', event.id)

    sendUpdate = (event) ->
      $.ajax
        type: 'PUT'
        url: scheduleUrl + "/#{event.id}"
        dataType: 'json'
        data: schedule: { start_at: event.start, end_at: event.end, title: event.title}

    createEvent = (startDate, endDate) ->
      $.ajax
        type: 'POST'
        url: scheduleUrl
        dataType: 'json'
        data: schedule: { start_at: startDate, end_at: endDate, title: 'working hours'}
        success: (data) ->
          calendar.fullCalendar 'unselect'
          calendar.fullCalendar 'renderEvent', data
