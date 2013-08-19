window.TbWidgets  = window.TbWidgets or {}

## Scroll to form
class TbWidgets.FormFixed

  topPixels: null

  constructor: (@container, @options) ->

    @container        = $(@container)
    @questionnaire    = $("#questionnaire")
    @conteiner_height = @container.outerHeight()
    @top_bar          = $(".contain-to-grid")
    @$window          = $(window)


    @updateFormFixed()

    @$window.scroll =>
      @updateFormFixed()



    $('#teaser_short, #form_teaser_button').on "click", (e) =>
      e.preventDefault()

      head_height =
      if @top_bar.css('position') is "fixed"
        @top_bar.height()
      else
        0

      topPx = @topPixels + @$window.height() - @conteiner_height - head_height
      $('body, html').animate
        scrollTop: topPx
        , 'slow'


  updateFormFixed: ->

    @topPixels = @questionnaire.offset().top - @$window.height() + @conteiner_height
    if @$window.scrollTop() >= @topPixels
      @container.hide()
    else
      @container.show()


## Form Closing
class TbWidgets.FormClosing

  options:
    padding : 0
    closeBtn: false
    scrolling: 'no'
    autoResize: false
    autoCenter: false
    fitToView: false
    helpers:
      overlay:
        locked: false
        closeClick: false
    keys:
      close: []

  constructor: (callback_yes, callback_no) ->

    console.log 123
    $("#maf_close_form").foundation('reveal', 'open')

    
    $('#maf_close_form_no').on 'click', (e) =>
      e.preventDefault()
      $("#maf_close_form").foundation('reveal', 'close')
      callback_no()

    $('#maf_close_form_yes').on 'click', (e) =>
      e.preventDefault()
      $("#maf_close_form").foundation('reveal', 'close')
      callback_yes()



## Form textfield focus
class TbWidgets.TexfieldFocus

  constructor: (@container, @options) ->

    @container  = $(@container)
    @input      = @container.find "input"

    
    @input.on "focus", =>

      @container.addClass "textfieldActive"


    @input.on "blur", =>

      @container.removeClass "textfieldActive"


    @input.on "select2-open", =>
        @container.addClass "textfieldActive"

    @input.on "select2-close", =>
      @container.removeClass "textfieldActive"





$ ->

  $("#questionnaire-fixed").each (i, container) ->

    new TbWidgets.FormFixed container


  # $("#questionnaire").find(".textfield").each (i, container) ->

  #   new TbWidgets.TexfieldFocus container

  # $("#questionnaire").find("#maf_accept_conditions_link").on "click", (e) ->
  #   e.preventDefault()
  #   $.fancybox.open "#maf_accept_conditions_text",
  #     padding : 0

  # $("#questionnaire").find('#maf_foreign_relations_link').on 'click', (e) ->
  #   e.preventDefault()
  #   $.fancybox.open '#maf_foreign_relations_text',
  #     padding : 0
