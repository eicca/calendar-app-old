class App.Lib.Modal extends Backbone.View
  template: JST['lib_templates/modal']
  className: 'reveal-modal'

  events:
    'click .delete': 'onDelete'

  initialize: () ->
    _(this).bindAll()

  render: ->
    @$el.html(@template(content: @content(), title: @title))
    $('body').append(@el)
    @$el.reveal
      animation: 'none'
      closeOnBackgroundClick: true
      closed: @modalClosed
    console.log @$el
    return this

  modalClosed: ->
    @unbind()
    @remove()

  onDelete: ->
    alert 'poka'
