class App.Lib.Modal extends Backbone.View
  template: JST['lib_templates/modal']
  className: 'reveal-modal'

  initialize: ->
    _(this).bindAll()

  render: ->
    @$el.html(@template(content: @content(attrs: @attrs), title: @title))
    $('body').append(@el)
    @$el.reveal
      animation: 'none'
      closeOnBackgroundClick: true
      closed: @modalClosed
    return this

  closeModal: ->
    @$el.trigger('reveal:close')

  modalClosed: ->
    @unbind()
    @remove()
