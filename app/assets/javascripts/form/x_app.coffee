window.TBank ?= {}

if typeof Object.getPrototypeOf isnt "function"
  if "".__proto__ is String::
    Object.getPrototypeOf = (object) ->
      object.__proto__
  else
    Object.getPrototypeOf = (object) ->
     object.constructor::

String::capitalize = () ->
  $.map(this.split(/\s+/), (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join ' '

String.prototype.toTranslit = ->
    text =  @
    text.replace /([а-яё])/gi, (all, character, i) ->
        t = ['yo','a','b','v','g','d','e','zh','z','i','y','k','l','m','n','o','p','r','s','t','u','f','h','c','ch','sh','shch','','y','','e','yu','ya']
        code = character.charCodeAt(0)
        next = text.charAt(i + 1)
        index = if code == 1025 || code == 1105
            0
        else
            if code > 1071
                code - 1071
            else
                code - 1039
        next = next && next.toUpperCase() is next ? 1 : 0
        if character.toUpperCase() is character
          if next
            t[ index ].toUpperCase()
          else
            t[ index ].substr(0,1).toUpperCase() + t[ index ].substring(2)
        else
          t[index]

$ ->
  if $("#questionnaire").length
    app = new TBank.App("#questionnaire")
    #console.log app
    app.start()
  #api = new TBank.Api 'deposite', "Тбанк",'Депозитная'

  #api.getUniqID (uniqID)->
      ##console.log uniqID

  #api.sendSMS "+7 (917) 344-11-06", (status)->
      ##console.log 'sendSMS', status

  #api.checkMobile "+7 (917) 344-11-06", (status)->
      ##console.log 'checkMobile', status

  #api.checkCode "+7 (926) 097-20-36", 37705, (status)->
      ##console.log 'checkCode', status

  #api.sendMailFinalStep new TBank.SendModel, (status)->
      ##console.log 'sendMailFinalStep', status

  #api.sendMobileStep new TBank.SendModel, (status)->
      ##console.log 'sendMobileStep', status

