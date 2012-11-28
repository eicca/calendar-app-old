$ ->
  $('#scheduler').scheduler(debug: true)

  calendar = $('#schedule')
  calendar.fullCalendar
    defaultView: 'agendaWeek'
    events: '/schedules'
    editable: true

    header:
      left: 'title'
      center: 'agendaWeek, month'
      right: 'today prev,next'
    dayClick: (date, allDay, jsEvent, view) ->
      return if view.name != 'agendaWeek'
      endDate = new Date(date)
      endDate.setHours(endDate.getHours() + 1)
      $.ajax
        type: 'POST'
        url: '/schedules'
        dataType: 'json'
        data: schedule: { start_at: date, end_at: endDate, title: 'working hours'}
      calendar.fullCalendar('refetchEvents')

    eventResize: (event) ->
      sendUpdate event
    eventDrop: (event) ->
      sendUpdate event

    eventClick: (event) ->
      $.ajax
        type: 'DELETE'
        url: "/schedules/#{event.id}"
        dataType: 'json'
        success: ->
          calendar.fullCalendar('removeEvents', event.id)

    sendUpdate = (event) ->
      $.ajax
        type: 'PUT'
        url: "/schedules/#{event.id}"
        dataType: 'json'
        data: schedule: { start_at: event.start, end_at: event.end, title: event.title}

