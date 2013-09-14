window.TBank = window.TBank || {}
class TBank.Api
    types_form:
      deposite: 'Депозитная'
      credit: 'Кредитная'
      creditspain: 'Кредитная'
      transfer: 'Трансферная'
      business: 'Бизнес'
      pifanket: 'Депозитная'
      buhsoft: 'Бухсофт'
      mtp: 'Кредитная карта (Мобильная точка продаж)'

    resources:
        deposite:
            uniqID: '/ajax/get/uniqID/'
            checkMobile: '/ajax/sms/check-mobile/'
            sendSMS: '/ajax/sms/send/'
            checkCode: '/ajax/sms/check-code/'
            sendMailFinalStep: '/ajax/client-form/mail/final/'
            sendMailMobileStep: '/ajax/client-form/mail/mobile/'
        credit:
            uniqID: '/ajax/get/uniqID/'
            checkMobile: '/ajax/sms/check-mobile/'
            sendSMS: '/ajax/sms/send/'
            checkCode: '/ajax/sms/check-code/'
            sendMailFinalStep: '/ajax/credit-account-form/mail/final/'
            sendMailMobileStep: '/ajax/credit-account-form/mail/mobile'
        creditspain:
            uniqID: '/ajax/get/uniqID/'
            checkMobile: '/ajax/sms/check-mobile/'
            sendSMS: '/ajax/sms/send/'
            checkCode: '/ajax/sms/check-code/'
            sendMailFinalStep: '/ajax/credit-account-form/mail/final/'
            sendMailMobileStep: '/ajax/credit-account-form/mail/mobile'
        transfer:
            uniqID: '/ajax/get/uniqID/'
            checkMobile: '/ajax/sms/check-mobile/'
            sendSMS: '/ajax/sms/send/'
            checkCode: '/ajax/sms/check-code/'
            sendMailFinalStep: '/ajax/balance-transfer-form/mail/final/'
            sendMailMobileStep: '/ajax/balance-transfer-form/mail/mobile/'
        business:
            uniqID: '/ajax/get/uniqID/'
            sendMailFinalStep: '/ajax/business-form/send/'
        pifanket:
            uniqID: '/ajax/get/uniqID/'
            checkMobile: '/ajax/sms/check-mobile/'
            sendSMS: '/ajax/sms/send/'
            checkCode: '/ajax/sms/check-code/'
            sendMailFinalStep: '/ajax/client-form/mail/final/'
            sendMailMobileStep: '/ajax/client-form/mail/mobile'
        mtp:
            uniqID: '/ajax/get/uniqID/'
            sendMailFinalStep: '/ajax/credit-account-form/mail/final/'
        buhsoft:
            uniqID: '/ajax/get/uniqID/'
            sendMailFinalStep: '/ajax/buhsoft-form/send/'

    constructor: (@type, @product) ->
        @api_resourses = @resources[@type]
        @type_form = @types_form[@type]

    getUniqID:(callback) ->
        $.getJSON @api_resourses.uniqID, product: @product, (response) ->
            uniqID = response.uniqID
            callback uniqID

    checkMobile: (mobile_phone, callback)->
        $.getJSON @api_resourses.checkMobile, {mobile: mobile_phone, type_form: @type_form}, (result) ->
            callback result.is_allowed

    sendSMS: (mobile_phone, callback) ->
        $.getJSON @api_resourses.sendSMS, { mobile: mobile_phone, type_form: @type_form }, (result) ->
            callback result.success

    checkCode: (mobile_phone, code, callback) ->
        $.getJSON @api_resourses.checkCode, {mobile: mobile_phone, code: code, type_form: @type_form}, (result) ->
            callback result.success

    sendMailFinalStep: (model, callback) ->

        request = $.ajax 
          url:      @api_resourses.sendMailFinalStep
          type:     "POST"
          data:     model.toJSON()
          dataType: "json"

        request.done (result) =>
          callback result.success

        request.fail (jqXHR, textStatus) =>
          callback textStatus


    sendMobileStep: (model, callback) ->
        $.post @api_resourses.sendMailMobileStep,
            model.toJSON(),
            (result) ->
                callback result.success
            ,'json'



class TBank.Api_test
    constructor: (@type, @product) ->

    getUniqID:(callback) ->
      uniqID = '123214'
      callback uniqID

    checkMobile: (mobile_phone, callback)->
      callback true

    sendSMS: (mobile_phone, callback) ->
      callback true

    checkCode: (mobile_phone, code, callback) ->
      callback true

    sendMailFinalStep: (model, callback) ->

      callback true

        # request = $.ajax 
        #   url:      @api_resourses.sendMailFinalStep
        #   type:     "POST"
        #   data:     model.toJSON()
        #   dataType: "json"

        # request.done (result) =>
        #   callback result.success

        # request.fail (jqXHR, textStatus) =>
        #   callback textStatus


    sendMobileStep: (model, callback) ->
        $.post @api_resourses.sendMailMobileStep,
            model.toJSON(),
            (result) ->
                callback result.success
            ,'json'



