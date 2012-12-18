class App.Views.LessonNew extends App.Lib.Modal
  content: JST['lessons/lesson_new']
  title: 'Create lesson'

  events:
    'click .ok': 'createLesson'
    'click .cancel': 'closeModal'

  initialize: (@attrs, @collection) ->
    super

  createLesson: ->
    that = this
    @collection.create({lesson: @attrs},
      success: (data) ->
        that.collection.trigger 'item:created', data
      error: (data) ->
        #alert data
    )
    @closeModal()
