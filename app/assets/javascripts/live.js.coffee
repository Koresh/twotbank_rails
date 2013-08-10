# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(".format-choice-block").find("header").find("a").on "click", (e) ->

    e.preventDefault()

    $(".format-choice-block").find("header").find("a").removeClass "active"
    $(this).addClass "active"
    $(".format-choice-block").find(".content-item").removeClass "active"
    index = $(this).data("index")
    $(".format-choice-block").find(".content-item").eq(index).addClass "active"

    false
