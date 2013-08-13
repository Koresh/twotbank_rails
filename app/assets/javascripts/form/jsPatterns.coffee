class JsPatterns

  windowOnScroll: (callback, delay)->

    delay or= 250
    scrollTimeout = null

    $(window).scroll =>

      if scrollTimeout
        clearTimeout scrollTimeout
        scrollTimeout = null

      scrollTimeout = setTimeout callback, delay


$ ->
  
  window.Patterns = new JsPatterns()

  return