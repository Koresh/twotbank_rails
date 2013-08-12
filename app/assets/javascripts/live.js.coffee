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

  $(".questionnaire-delivery-type-change").find("ul").find("a").on "click", (e) ->

    e.preventDefault()

    $(".questionnaire-delivery-type-change").find("ul").find("a").removeClass "active"
    $(this).addClass "active"
    index = $(this).data("index")
    $(".questionnaire-delivery-type-block").find(".item").removeClass("active").eq(index).addClass "active"

  $("input[name='maf_way_to_get']").on "change", (e) ->
    $("input[name='maf_way_to_get']").each ->
      if $(this).is(":checked")
        $($(this).data("block")).show()
      else
        $($(this).data("block")).hide()

