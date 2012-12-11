class App.Views.ScheduleNew extends App.Lib.Modal
  content: JST['schedules/schedule_new']
  title: 'Create event'

  events:
    'click .ok': 'createSchedule'
    'click .cancel': 'closeModal'

  initialize: (@attrs, @collection) ->
    super

  createSchedule: ->
    that = this
    @collection.create(@attrs,
      success: (data) ->
        that.collection.trigger 'item:created', data
      error: (data) ->
        alert data
    )
    @closeModal()
