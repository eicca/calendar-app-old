class App.Views.LessonNew extends App.Lib.Modal
  content: JST['lessons/lesson_new']
  title: 'Create lesson'
  lessonCreatedTemplate: JST['lessons/lesson_created']

  events:
    'click .ok': 'createLesson'
    'click .cancel': 'closeModal'

  initialize: (@attrs, @collection) ->
    super

  createLesson: ->
    @collection.create({lesson: @attrs},
      success: @lessonCreated
      error: (data) =>
        console.log data
        alert 'impossibru'
        @closeModal()
    )

  lessonCreated: (data) ->
    @collection.trigger 'item:created', data
    @$el.html(@lessonCreatedTemplate())
