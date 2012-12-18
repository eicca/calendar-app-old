class App.Views.LessonsIndex extends App.Lib.BaseCalendar

  initialize: (opts) ->
    _(this).bindAll()
    @schedules = opts.schedules
    @lessons = opts.lessons
    @teacherId = @lessons.opts.teacherId
    @collections = [@schedules, @lessons]
    super(opts)

  render: ->
    super
    @renderEvents(@schedules)
    @renderEvents(@lessons)
    return this

  select: (startDate, endDate) ->
    attrs = start_at: startDate, end_at: endDate, teacher_id: @teacherId
    console.log attrs
    view = new App.Views.LessonNew(attrs, @lessons)
    view.render()

  eventClick: (event) ->
    return if event.eventType is 'schedule'
    model = @lessons.get(event.id)
    view = new App.Views.LessonEdit(model)
    view.render()

  eventDropOrResize: (event, revert) ->
    data = { lesson: { start_at: event.start, end_at: event.end } }
    @lessons.get(event.id).save data,
    error: (data, response) ->
      revert()
      alert JSON.stringify(response)
