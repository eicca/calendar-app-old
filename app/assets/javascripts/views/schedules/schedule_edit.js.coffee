class App.Views.ScheduleEdit extends App.Lib.Modal
  content: JST['schedules/schedule_edit']
  title: 'Edit event'

  events:
    'click .delete': 'deleteSchedule'
    'click .toggle-recurrence': 'toggleRecurrence'
    'click .cancel': 'closeModal'

  initialize: (@model) ->
    @attrs = @model.attributes
    super

  toggleRecurrence: ->
    @model.save(recurring: !@attrs.recurring)
    @closeModal()

  deleteSchedule: ->
    #that = this
    @model.destroy
      success:  ->
        #that.model.trigger 'deleted', this
      error: (data) ->
        alert data.responseText
    @closeModal()
