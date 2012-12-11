class App.Views.ScheduleEdit extends App.Lib.Modal
  content: JST['schedules/schedule_edit']
  title: 'Edit event'

  events:
    'click .delete': 'deleteSchedule'
    'click .cancel': 'closeModal'

  initialize: (@model) ->
    @attrs = @model.attributes
    super

  deleteSchedule: ->
    #that = this
    @model.destroy
      success:  ->
        #that.model.trigger 'deleted', this
      error: (data) ->
        alert data.responseText
    @closeModal()
