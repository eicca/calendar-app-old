# Reference jQuery
$ = jQuery

$.widget 'ui.scheduler'

  options:
    debug: false

  # Simple logger
  log: (msg) ->
    console?.log msg if @options.debug

  onCellClick: (e) ->
    e.preventDefault()
    $(this).toggleClass 'ui-state-active'

  generateTable: ->
    tableHtml = ''
    tableTr = ''
    date = new Date(1,1,1,0,0,0)
    for i in [0..47]
      if i%6 == 0
        tableHtml += "<tr>#{tableTr}</tr>"
        tableTr = ''
      tableTr += "<td><a class='ui-state-default' href='#'>#{date.getHours()}:#{date.getMinutes()}</a></td>"
      date.setMinutes(date.getMinutes() + 30)
    tableHtml += "<tr>#{tableTr}</tr>"
    return tableHtml

  createTimepicker: ->
    @timepicker = $('<div/>',
      'class': 'ui-timepicker ui-datepicker ui-datepicker-inline ui-widget ui-widget-content ui-border-all'
      'style': 'display: block'
    )
    #header
    @timepicker.append $('<div/>',
      'class': 'ui-widget-header ui-helper-clearfix ui-corner-all'
    ).append "<div class='ui-datepicker-title'>Working Hours</div>"
    #table with hours
    table = $('<table/>').append(@generateTable())
    $('tr a', table).hover(
      -> $(this).addClass 'ui-state-hover'
      -> $(this).removeClass 'ui-state-hover'
    ).click(@onCellClick)
    #append all table to timepicker
    @timepicker.append table

  _create: ->
    @element.addClass('hasScheduler')
    @element.datepicker()

    @createTimepicker()
    @element.append(@timepicker)

    @element.append("<div class='clear'></div>")
