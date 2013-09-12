window.TbWidgets  = window.TbWidgets or {}

class TbWidgets.CallbackForm

  constructor: (@container) ->
    @container.on "submit", (e) =>
      e.preventDefault()
      if @form_valid()
        @send_form()
      false


  form_valid: ->
    valid = true
    @container.find(".input-field.required").each (i, container) ->
      $container  = $(container)
      if $.trim( $container.find("input").val()) is ""
        $container.addClass("error")
        valid = false
      else
        $container.removeClass("error")

    if valid
      return true
    else
      return false

  send_form: ->
    $.ajax 
      type: "POST"
      url: @container.attr("action")
      data: @container.serialize()
      success: @final_string()

  final_string: ->
    @container.parent().html "<h2>Ваша заявка успешно принята, пожалуйста ожидайте звонка в указаное время.</h2><a class='close-reveal-modal'>×</a>"






$ ->
  new TbWidgets.CallbackForm $("#callback-form")