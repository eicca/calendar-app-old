$ ->
  calendar = $('#lessons-picker')

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
    editable: false
    minTime: '7:00' # start of the working day
    maxTime: '20:00' # end of the working day
    allDaySlot: false
    allDayDefault: false
    selectable: true

    header:
      left: 'title'
      right: 'today prev,next'

    #dayClick: (date, allDay, jsEvent, view) ->
      #return if view.name != 'agendaWeek'
      #endDate = new Date(date)
      #endDate.setHours(endDate.getHours() + 1)
      #createEvent(date, endDate)
    eventAfterRender: (event, element, view) ->
      $el  = $(element)
      if $el.hasClass('teachers-event')
        $el.css('width', '20px')

    select: (startDate, endDate, allDay, jsEvent, view) ->
      createEvent(startDate, endDate)

    selectHelper: true

    eventResize: (event,dayDelta,minuteDelta,revertFunc) ->
      sendUpdate event, revertFunc
    eventDrop: (event,dayDelta,minuteDelta,allDay,revertFunc) ->
      sendUpdate event, revertFunc

    eventClick: (event) ->
      return if event.className != 'lessons-event'
      $.ajax
        type: 'DELETE'
        url: lessonsUrl + "/#{event.id}"
        dataType: 'json'
        success: ->
          calendar.fullCalendar('removeEvents', event.id)

    sendUpdate = (event, revertFunc) ->
      $.ajax
        type: 'PUT'
        url: lessonsUrl + "/#{event.id}"
        dataType: 'json'
        data: lesson: { start_at: event.start, end_at: event.end, title: event.title}
        success: (data, status) ->
          console.log status
        error: (data, status, error) ->
          alert data.responseText
          revertFunc()

    createEvent = (startDate, endDate) ->
      $.ajax
        type: 'POST'
        url: lessonsUrl
        dataType: 'json'
        data: lesson: { teacher_id: teacherId, start_at: startDate, end_at: endDate, title: 'lesson'}
        success: (data) ->
          calendar.fullCalendar 'unselect'
          calendar.fullCalendar 'renderEvent', data
        error: (data, status, error) ->
          alert data.responseText
