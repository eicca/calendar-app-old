_.mixin

  formatDate: (date) ->
    $.fullCalendar.formatDate(
      $.fullCalendar.parseDate(date), 'HH:MM dd-M-yy'
    )
