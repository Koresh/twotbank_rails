window.TbWidgets  = window.TbWidgets or {}

class TbWidgets.PressAboutCircle

  constructor: (@container) ->
    @arrow_left           = @container.find ".arrow-left"
    @arrow_right          = @container.find ".arrow-right"
    @authors_links        = @container.find(".authors-block-overflow").find "ul"
    @authors_link         = @authors_links.find("li").find("a")
    @authors_links_size   = @authors_links.find("li").length
    @authors_link_width   = @authors_links.find("li").outerWidth()
    @authors_links_width  = @authors_link_width * @authors_links_size
    overflow_block_width  = @container.find(".authors-block-overflow").width()
    @content_list_items   = @container.find(".content-list").find "li"
    @shift_size           = 0


    @authors_links.width @authors_links_width

    @arrow_right.addClass("disabled") if @authors_links_width < overflow_block_width

    @arrow_right.on "click", (e) =>
      e.preventDefault()
      unless @arrow_right.hasClass "disabled"
        @shift_right()
      @arrow_right.addClass("disabled")  if ( @shift_size > ( @authors_links_size - 2 ) ) 

    @arrow_left.on "click", (e) =>
      e.preventDefault()
      unless @arrow_left.hasClass "disabled"
        @shift_left()
      @arrow_left.addClass("disabled") if ( @shift_size is 0 )

    @authors_link.on "click", (e) =>
      e.preventDefault()
      @authors_link.removeClass("active").find(e.target).parents("a").addClass "active"
      @content_list_items.removeClass("active").eq( $(e.target).parents("li").index() ).addClass "active"



  shift_right: ->
    @shift_size++
    @authors_links.css marginLeft: "-#{@shift_size * @authors_link_width}px"
    @arrow_left.removeClass "disabled"

  shift_left: ->
    @shift_size--
    @authors_links.css marginLeft: "-#{@shift_size * @authors_link_width}px"
    @arrow_right.removeClass "disabled"


$ ->
  new TbWidgets.PressAboutCircle $("#press-about-circle")