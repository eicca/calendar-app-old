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
    new App.Views.LessonNew(attrs, @lessons).render()

  eventClick: (event) ->
    return if (event.eventType isnt 'lesson') or (not event.editable)
    model = @lessons.get(event.id)
    new App.Views.LessonEdit(model).render()

  eventDropOrResize: (event, revert) ->
    if event.eventType isnt 'lesson'
      revert()
      return
    attrs = { lesson: { start_at: event.start, end_at: event.end } }
    model = @lessons.get(event.id)
    new App.Views.LessonConfirmChange(model, attrs, revert).render()
