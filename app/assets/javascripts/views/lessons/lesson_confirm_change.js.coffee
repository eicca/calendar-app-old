class App.Views.LessonConfirmChange extends App.Lib.Modal
  content: JST['lessons/lesson_confirm_change']
  title: "You're about to change requested lesson"

  events:
    'click .ok': 'updateLesson'
    'click .cancel': 'closeModal'

  initialize: (@model, @attrs, @revert) ->
    super

  updateLesson: ->
    @model.reschedule @attrs,
      success: =>
        @revert = ->
        @closeModal()
      error: (data) =>
        alert 'error'
        console.log data
        @closeModal()

  beforeModalClosed: ->
    @revert()
