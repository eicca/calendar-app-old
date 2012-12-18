_.mixin

  formatDate: (date) ->
    $.fullCalendar.formatDate(
      $.fullCalendar.parseDate(date), 'H:M dd-M-yy'
    )
