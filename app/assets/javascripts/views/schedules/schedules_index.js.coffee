class App.Views.SchedulesIndex extends App.Lib.BaseCalendar

  initialize: (opts) ->
    _(this).bindAll()
    @schedules = opts.schedules
    @lessons = opts.lessons
    @collections = [@schedules, @lessons]
    super(opts)

  render: ->
    super
    @renderEvents(@schedules)
    @renderEvents(@lessons)
    return this

  select: (startDate, endDate) ->
    attrs = title: 't', start_at: startDate, end_at: endDate
    view = new App.Views.ScheduleNew(attrs, @schedules)
    view.render()

  eventClick: (event) ->
    if event.eventType is 'schedule'
      model = @schedules.get(event.id)
      new App.Views.ScheduleEdit(model).render()
    else
      model = @lessons.get(event.id)
      new App.Views.LessonInfoForTeacher(model).render()

  eventDropOrResize: (event, revert) ->
    if event.eventType isnt 'schedule'
      revert()
      return
    data = { schedule: {start_at: event.start, end_at: event.end } }
    @schedules.get(event.id).save data,
    error: (data, response) ->
      revert()
      alert 'impossibru'
