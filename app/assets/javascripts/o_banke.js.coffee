# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  $(".info-about-documents-section").find(".header").find("a").on "click", (e)->
    e.preventDefault()

    unless $(this).hasClass("active")
      $(".info-about-documents-section").find(".header").find("a.active").removeClass("active")
      index = $(this).addClass("active").parent("li").index()
      $(".info-about-documents-section").find(".documents-inline-block-list").addClass("hide").eq(index).removeClass("hide")

    return false


