class App.Views.LessonInfoForTeacher extends App.Lib.Modal
  content: JST['lessons/lesson_info_for_teacher']
  title: 'Lesson info'

  events:
    'click .close': 'closeModal'

  initialize: (@model) ->
    @attrs = @model.attributes
    super
