class App.Views.LessonEdit extends App.Lib.Modal
  content: JST['lessons/lesson_edit']
  title: 'Edit lesson'

  events:
    'click .delete': 'deleteLesson'
    'click .cancel': 'closeModal'

  initialize: (@model) ->
    @attrs = @model.attributes
    super

  deleteLesson: ->
    #that = this
    @model.destroy
      success:  ->
        #that.model.trigger 'deleted', this
      error: (data) ->
        alert data.responseText
    @closeModal()
