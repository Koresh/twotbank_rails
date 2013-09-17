window.TBank ?= {}
window.TBank.Layout ?= {}


class TBank.StartForm extends TBank.StepView
  _model: TBank.Form1

  originalEvents:
    "click #send_sms_again"  : "send_sms_again"

  send_sms_again: (e) ->
    e.preventDefault()
    $('#send_sms_again').addClass('disabled');
    @api.sendSMS @model.get('maf_mobile_phone'), (status) =>
      @sendmodel.set 'mobile_phone', @model.get('maf_mobile_phone')
      $('#send_sms_again').removeClass('disabled');
      #console.log "SMS send"
    return false

  stepvalidate: (callback) ->
    @api.checkMobile @model.get('maf_mobile_phone'), (status)=>
      if status
        $('#maf_mobile_phone').next().hide();
        @clearError 'maf_mobile_phone'

        $("#first_step_submit").hide()
        $("#send_sms_again").show()
        $("#send_sms_again").parent().show()

        @api.sendSMS @model.get('maf_mobile_phone'), (status) =>
          #console.log "SMS send"
      else
        $('#maf_mobile_phone').next().css("display", "inline-block");
        @setError 'maf_mobile_phone'

      callback(status)

  openStep: (callback) ->
    $("#first_step_submit").show()
    $("#send_sms_again").hide()
    $("#send_sms_again").parent().hide()
    callback() if typeof( callback ) is "function"



  closeStep: (callback) ->
    callback() if typeof( callback ) is "function"


class TBank.StartFormPif extends TBank.StepView
  _model: TBank.Form1Pif

  openStep: (callback) ->
    callback() if typeof( callback ) is "function"

  closeStep: (callback) ->
    callback() if typeof( callback ) is "function"


class TBank.StartFormMTP extends TBank.StepView
  _model: TBank.MTPFormSTEP2

  openStep: (callback) ->
    callback() if typeof( callback ) is "function"

  closeStep: (callback) ->
    callback() if typeof( callback ) is "function"

  afterRender: ->
    @model.on "change:maf_foreign_relations_flag", =>
      @relationsChange()

    @model.on "change:maf_first_name change:maf_last_name", =>
      first_name = @model.get 'maf_first_name'
      last_name = @model.get 'maf_last_name'
      @model.set 'maf_zagran_fio', "#{first_name} #{last_name}".toTranslit()

    @model.trigger "change:maf_foreign_relations_flag"

    @changeHomePhone()

    unless @model.get 'maf_connect_mobile'
      @model.set 'maf_connect_mobile', @sendmodel.get 'mobile_phone'

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: true

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: false

    @work_hash = ["maf_work_title","maf_work_expirience","maf_work_phone","maf_work_phone_add"]

    index = $("input[name='maf_city_office']:checked").parents(".offices").index(".offices")
    @$el.find(".citySelect").find("span").eq(index).trigger "click"


  relationsChange: ->
    if @model.attributes["maf_foreign_relations_flag"] is "yes"
      $("#maf_foreign_relations_field").show()
    else
      $("#maf_foreign_relations_field").hide()

  originalEvents:
    "change #maf_connect_phone_home" : "changeHomePhone"
    "field-disabled"  : "addDisabledHash"
    "field-enabled"   : "rmDisabledHash"
    "change #maf_work": "setWorkFields"

  setWorkFields: ->
    idle = $("#maf_work").find("option:selected").attr "idle"
    #console.log idle
    if ( idle is "false" ) or ( not idle )
      @enableWork()
    else
      @disableWork()


  disableWork: ->
    @addressForm.disableWork()
    for item in @work_hash
      $("##{item}").attr("disabled","disabled").parent().addClass("disabled")
      @addDisabledHash null, name: item

  enableWork: ->
    @addressForm.enableWork()
    for item in @work_hash
      $("##{item}").removeAttr("disabled").parent().removeClass("disabled")
      @rmDisabledHash null, name: item

  changeHomePhone: ->
    $this = $ "#maf_connect_phone_home"

    if $this.is ":checked"
      $("#maf_connect_phone_name_field").hide()
      @disabledHash.push "maf_connect_phone_name"
      $("#maf_connect_phone_title").text "Домашний телефон"
    else
      $("#maf_connect_phone_name_field").show()
      @disabledHash = _.without @disabledHash, "maf_connect_phone_name"
      $("#maf_connect_phone_title").text "Телефон контактного лица"


  addDisabledHash: (e, data) ->
    data = data.name
    @disabledHash.push data

  rmDisabledHash: (e, data) ->
    data = data.name
    @disabledHash = _.uniq( _.without @disabledHash, data )

  getDisableHash: ->
    @disabledHash


  afterGotoStep: ->
    unless @model.get 'maf_connect_mobile'
      @model.set 'maf_connect_mobile', @sendmodel.get 'mobile_phone'


class TBank.PersonalForm extends TBank.StepView
  _model: TBank.Form2

  afterGotoStep: ->
    #console.log "afterRender", @model
    first_name = @sendmodel.get 'first_name'
    last_name = @sendmodel.get 'last_name'
    if first_name && last_name
      @model.set 'maf_zagran_fio', "#{first_name} #{last_name}".toTranslit()

    

  afterRender: ->
    @model.on "change:maf_foreign_relations_flag", =>
      @relationsChange()

    @model.trigger "change:maf_foreign_relations_flag"


  relationsChange: ->

    #console.log @model.attributes["maf_foreign_relations_flag"]

    if @model.attributes["maf_foreign_relations_flag"] is "yes"
      $("#maf_foreign_relations_field").show()
    else
      $("#maf_foreign_relations_field").hide()


class TBank.PersonalFormPif extends TBank.StepView
  _model: TBank.Form2Pif
      


class TBank.ContactForm extends TBank.StepView
  _model: TBank.Form3


  originalEvents:
    "field-disabled"  : "addDisabledHash"
    "field-enabled"   : "rmDisabledHash"

  addDisabledHash: (e, data) ->
    data = data.name
    @disabledHash.push data
    #console.log @disabledHash

  rmDisabledHash: (e, data) ->
    data = data.name
    @disabledHash = _.uniq( _.without @disabledHash, data )
    #console.log @disabledHash

  getDisableHash: ->
    @disabledHash

  afterGotoStep: ->
    unless @model.get 'maf_connect_mobile'
      @model.set 'maf_connect_mobile', @sendmodel.get 'mobile_phone'

  afterRender: ->

    #console.log @model.toJSON()

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: true


  afterCommit: ->
    # Отключили курьеров
    try
      @sendmodel.setLivingAddress @addressForm.getLivingAddress()
      @sendmodel.setRegisterAddress @addressForm.getRegisterAddress()


class TBank.ContactFormPif extends TBank.ContactForm
  _model: TBank.Form3Pif

  afterRender: ->

    #console.log @model.toJSON()

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: false
      suffix: "reg"



class TBank.ContactFormHomePhone extends TBank.StepView
  _model: TBank.Form31

  originalEvents:
    "change #maf_connect_phone_home" : "changeHomePhone"
    "field-disabled"  : "addDisabledHash"
    "field-enabled"   : "rmDisabledHash"


  changeHomePhone: ->
    $this = $ "#maf_connect_phone_home"

    if $this.is ":checked"
      $("#maf_connect_phone_name_field").hide()
      @disabledHash.push "maf_connect_phone_name"
      $("#maf_connect_phone_title").text "Домашний телефон"
    else
      $("#maf_connect_phone_name_field").show()
      @disabledHash = _.without @disabledHash, "maf_connect_phone_name"
      $("#maf_connect_phone_title").text "Телефон контактного лица"


  addDisabledHash: (e, data) ->
    data = data.name
    @disabledHash.push data

  rmDisabledHash: (e, data) ->
    data = data.name
    @disabledHash = _.uniq( _.without @disabledHash, data )

  getDisableHash: ->
    @disabledHash


  afterGotoStep: ->
    unless @model.get 'maf_connect_mobile'
      @model.set 'maf_connect_mobile', @sendmodel.get 'mobile_phone'


  afterRender: ->

    @changeHomePhone()

    unless @model.get 'maf_connect_mobile'
      @model.set 'maf_connect_mobile', @sendmodel.get 'mobile_phone'

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: true

  afterCommit: ->
    # Отключили курьеров
#    try
#      @sendmodel.setLivingAddress @addressForm.getLivingAddress()
#      @sendmodel.setRegisterAddress @addressForm.getRegisterAddress()



class TBank.Step4 extends TBank.StepView
  _model: TBank.Form4

  originalEvents:
    "change input[name='maf_way_to_get']": "whayToGet"
    "click .citySelect span" : "citySelect"
    "change input[name='maf_delivery_type']" : "deliveryChange"


  deliveryChange: (e) ->
    if $(e.target).val() is "living"
      $("#maf_delivery_address").val( @sendmodel.getLivingAddress() ).trigger "change"
    else
      $("#maf_delivery_address").val( @sendmodel.getRegisterAddress() ).trigger "change"

  stepvalidate: (callback) ->
    #console.log 'stepvalidatedate'
    @api.checkCode @sendmodel.get('mobile_phone'), @model.get('maf_check_code'), (status)=>
      if status
        $('#maf_check_code_error').hide()
        @clearError 'maf_mobile_phone'
      else
        $('#maf_check_code_error').show()
        @setError 'maf_mobile_phone'
      callback(status)

  whayToGet: (e) ->
    $this = $ e.target
    #console.log $this.val()
    if $this.val() is "courier"
      @$el.find(".address").show()
      @$el.find("#city_offices_block").hide()
      @disabledHash = _.without @disabledHash, "maf_delivery_address"
    else
      @$el.find(".address").hide()
      @$el.find("#city_offices_block").show()
      @disabledHash.push "maf_delivery_address"

    #console.log @disabledHash

  citySelect: (e) ->
    $this = $ e.target
    id    = $this.attr "id"
    $this.addClass("active").siblings().removeClass "active"
    @$el.find(".offices").hide()
    @$el.find("##{id}_offices").show().find("input").eq(0).trigger "click"

  # Костыль, чтобы убрасть доставку курьером
  hideCourier: ->
    #$("#maf_way_to_get_courier").parents(".inline-fields").hide()
    #$("#maf_way_to_get_office").parents(".inline-fields").hide().parent().addClass("text-center").html("<div clas='input-field'>В офисе</div>")
    $("#maf_way_to_get_office").parents(".inline-fields").parent().addClass("text-center").html("<div class='columns small-12 input-field'>В офисе</div>")


  afterGotoStep: ->
    $("input[name='maf_delivery_type']").trigger "change"


  afterRender: ->

    index = $("input[name='maf_city_office']:checked").parents(".offices").index(".offices")
    @$el.find(".citySelect").find("span").eq(index).trigger "click"



class TBank.Step4Pif extends TBank.Step4
  _model: TBank.Form4Pif


class TBank.Step4Credit extends TBank.Step4
  _model: TBank.Form41


  additionalEvents:
    "field-disabled"  : "addDisabledHash"
    "field-enabled"   : "rmDisabledHash"
    "change #maf_work": "setWorkFields"


  setWorkFields: ->
    idle = $("#maf_work").find("option:selected").attr "idle"
    #console.log idle
    if ( idle is "false" ) or ( not idle )
      @enableWork()
    else
      @disableWork()
      

  disableWork: ->
    @addressForm.disableWork()
    for item in @work_hash
      $("##{item}").attr("disabled","disabled").parents(".input-field").removeClass("error").find(".custom.dropdown").addClass("disabled")
      @addDisabledHash null, name: item

  enableWork: ->
    @addressForm.enableWork()
    for item in @work_hash
      $("##{item}").removeAttr("disabled").parents(".input-field").removeClass("error").find(".custom.dropdown").removeClass("disabled")
      @rmDisabledHash null, name: item

  addDisabledHash: (e, data) ->
    data = data.name
    @disabledHash.push data

  rmDisabledHash: (e, data) ->
    data = data.name
    @disabledHash = _.uniq( _.without @disabledHash, data )

  afterRender: ->

    @work_hash = ["maf_work_title","maf_work_expirience","maf_work_phone","maf_work_phone_add"]

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: false

    index = $("input[name='maf_city_office']:checked").parents(".offices").index(".offices")
    @$el.find(".citySelect").find("span").eq(index).trigger "click"

    #Костыль
    @hideCourier()


class TBank.Step4Transfer extends TBank.Step4Credit
  _model: TBank.Form42

  additionalEvents:
    "field-disabled"  : "addDisabledHash"
    "field-enabled"   : "rmDisabledHash"
    "change #maf_work": "setWorkFields"


  afterRender: ->
    @model.on "change", =>
      #console.log @model.toJSON()

    @work_hash = ["maf_work_title","maf_work_expirience","maf_work_phone","maf_work_phone_add"]

    @addressForm = new TBank.AddressForm
      container: @el
      model: @model
      is_sync: false

    index = $("input[name='maf_city_office']:checked").parents(".offices").index(".offices")
    @$el.find(".citySelect").find("span").eq(index).trigger "click"

    $add_credit  = $ "#add-current-credit-link"
    $current_credits_item = $("#current-credits-list").children(".item")


    @c_type_hash = [
      ["maf_credit_type_2","maf_bank_2","maf_credit_total_2","maf_credit_payment_2","maf_credit_year_2","maf_credit_sum_2"]
    ,
      ["maf_credit_type_3","maf_bank_3","maf_credit_total_3","maf_credit_payment_3","maf_credit_year_3","maf_credit_sum_3"]
    ,
      ["maf_credit_type_4","maf_bank_4","maf_credit_total_4","maf_credit_payment_4","maf_credit_year_4","maf_credit_sum_4"]
    ]

    for arr in @c_type_hash
      $this = $("##{arr[0]}")
      if $this.val() and ($this.val() isnt "")
        $(this).parents(".item").show()
        $add_credit.hide() if not $current_credits_item.filter(":hidden").length
        for key in arr
          @rmDisabledHash null, name: key

      else
        for key in arr
          @addDisabledHash null, name: key


    $add_credit.on "click", (e) =>
      e.preventDefault()
      $this   = $ e.target
      index   = $current_credits_item.filter(":hidden").first().index()
      $current_credits_item.filter(":hidden").first().show()
      $add_credit.hide() if not $current_credits_item.filter(":hidden").length


      for key in @c_type_hash[index - 1]
        @rmDisabledHash null, name: key




    @$el.find(".dashed.remove-current-credit-link").on "click", (e) =>
      e.preventDefault()
      $this   = $ e.target
      $parent = $this.parents(".item").hide()

      index = $parent.index()

      if $parent.siblings(".item").filter(":visible").length > 1
        $add_credit.show()

      for key in @c_type_hash[index - 1]
        @addDisabledHash null, name: key

        $("##{key}").parent().removeClass("error")



    @$el.find(".maf-credit-type").on "change", (e) =>
      $this   = $ e.target
      key     = $this.find("option:selected").attr "key"
      $items  = $this.parents(".info-first").next(".info-second")
      $labels = $items.find("label")

      $this.parents(".item").find('.input-field.error').removeClass "error"


      if ( key isnt "credit_card" ) and ( key isnt "null" )

        $items.show() if $items.is ":hidden"

        $labels.each ->
          $(this).text $(this).data("text-cash")

      else if key is "credit_card"

        $items.show() if $items.is ":hidden"

        $labels.each ->
          $(this).text $(this).data("text-card")

      else

        $items.hide() if $items.is ":visible"

        $labels.each ->
          $(this).text ""

    #Костыль
    @hideCourier()

class TBank.Step4CreditSpain extends TBank.Step4Credit
  _model: TBank.Form41spain

  afterRender: ->
    super
    $('.block-for-spain').toggle()

  dateParse: (date) ->
    [day, month, year] = date.split('.')
    (new window.Date(year, month-1, day)).getTime()

  stepvalidate: (callback) ->

    visa_from = @dateParse(@model.get 'maf_visa_from')
    visa_to = @dateParse(@model.get 'maf_visa_to')
    staying_from = @dateParse(@model.get 'maf_staying_from')
    staying_to = @dateParse(@model.get 'maf_staying_to')

    if staying_to - staying_from <= 28*86400*1000
      @clearError('maf_staying_to')
      @clearError('maf_staying_from')
      valid = true
    else
      @setError('maf_staying_to')
      @setError('maf_staying_from')
      valid = false

    if visa_to >= staying_to && visa_from <= staying_from
      @clearError('maf_staying_to')
      @clearError('maf_staying_from')
      valid &&= true
    else
      @setError('maf_staying_to')
      @setError('maf_staying_from')
      valid &&= false


    if valid
      super(callback)
    else
      callback( valid ) if typeof( callback ) is "function"

    @




class TBank.StartBusiness extends TBank.StepView
  _model: TBank.StartBusinessFrom

  additionalEvents:
    "change #baf_region": "anotherCity"
    "change input[name='baf_is_client']": "schetForBusiness"

  afterRender: ->
    @$baf_region = $("#baf_region")

    @anotherCity()


  schetForBusiness: (e) ->

    $this = $(e.target)

    if $this.val() is "yes"
      $("#schet-dlya-biznesa-field").hide()
    else
      $("#schet-dlya-biznesa-field").show()


  anotherCity: ->
    Foundation.libs.forms.refresh_custom_select(@$baf_region, true)
    if @$baf_region.val() is "Другой"
      $("#baf_cityfield").show()
      @disabledHash = _.uniq( _.without @disabledHash, "baf_city" )
    else
      $("#baf_cityfield").hide()
      @disabledHash.push "baf_city"


  openStep: (callback) ->
    callback() if typeof( callback ) is "function"


  closeStep: (callback) ->
    callback() if typeof( callback ) is "function"


class TBank.FinalBusiness extends TBank.StepView
  _model: TBank.FinalBusinessForm

  additionalEvents:
    "change input[type='checkbox']": "openSubInputs"

  afterRender: ->
    @$el.find(".sub-inputs").find("input").each (i, container) =>
      @disabledHash.push $(container).attr "name"

    #console.log @disabledHash

    @$el.find("input[type='checkbox']").each (i, container) =>
      if $(container).data("checked") is "checked"
        name = $(container).attr "name"
        $(container).trigger("change").parents(".CFEcheckbox").addClass("CFEcheckbox_checked")
        @model.set name, true


  openSubInputs: (e) ->
    #console.log e.target
    $this = $(e.target)
    if $this.is(":checked")
      $this.parents(".input-field").find(".sub-inputs").slideDown(150).find("input").each (i, container) =>
        @disabledHash = _.uniq( _.without @disabledHash, $(container).attr "name" )
        
    else
      $this.parents(".input-field").find(".sub-inputs").slideUp(150).find("input").each (i, container) =>
        @disabledHash.push $(container).attr "name"

  stepvalidate: (callback) ->
    valid = false
    if $("#schet-dlya-biznesa-field").is(":visible")
      valid = true
    else
      @$el.find(".input-field").not("#schet-dlya-biznesa-field").find("input[type='checkbox']").each (i, container) =>
        #console.log container
        valid = true if $(container).is(":checked")
        return true

      if valid
        $("#one_checkbox_valid").removeClass "alert"
      else
        $("#one_checkbox_valid").addClass "alert"

    callback( valid ) if typeof( callback ) is "function"

    @





class TBank.FinalStep extends Backbone.View

  initialize: (options) ->
    $('#maf_final_button').on 'click', @closeBtnClick
    $('.maf_final_button').on 'click', @closeBtnClick

    @api = options.api
    @sendmodel = options.sendmodel


  openStep: (callback) ->

    $("#preloader").show()

    @api.sendMailFinalStep @sendmodel, (status) =>

      #console.log status
      $("#preloader").hide()

      if status is "error"
        @gotoLastStep()
      else if status
        #@arboost()
        @success status
      else
        @reject status

      callback() if typeof(callback) is "function"

  arboost: ()->
    window.arboost_order_id = @sendmodel.get 'id'
    script = document.createElement("script")
    script.src = "/static/js/getArboostPixel.js"
    script.type = "text/javascript"
    document.getElementById('pixel').appendChild(script)

  gotoLastStep: ->
    router.navigate "final", trigger: true

  success: (status) ->
    $('#maf_success').foundation 'reveal', 'open'

  reject: (status) ->
    $('#maf_success').foundation 'reveal', 'open'

  afterGotoStep: ->


  closeStep: (callback) ->
    $('.reveal-modal').foundation 'reveal', 'close'
    callback() if typeof(callback) is "function"
    questView.clearLayout()

  closeBtnClick: (e) =>
    e.preventDefault()
    @closeStep()

class TBank.FinalStepDeposit extends TBank.FinalStep

class TBank.FinalStepBusiness extends TBank.FinalStep

  gotoLastStep: ->
    router.navigate "final", trigger: true

class TBank.FinalStepCredit extends TBank.FinalStep


class TBank.FinalStepTransfer extends TBank.FinalStep

class TBank.BuhsoftStep extends TBank.StepView
  _model: TBank.BuhsoftForm

  openStep: (callback) ->
    callback() if typeof( callback ) is "function"


  closeStep: (callback) ->
    callback() if typeof( callback ) is "function"

  stepvalidate: (callback) ->
    valid = false

    #console.log "123123123"

    $(".buhsoft-products").find(".item").find("input[type='checkbox']").each (i, container) =>
      #console.log container
      valid = true if $(container).is(":checked")
      return true

    if valid
      $("#one_checkbox_valid").removeAttr "style"
    else
      $("#one_checkbox_valid").css "color", "#FF0000"

    callback( valid ) if typeof( callback ) is "function"

    @

class TBank.FinalStepBuhsoft extends TBank.FinalStep

  gotoLastStep: ->
    router.navigate "step1", trigger: true

  afterRender: ->
    @$el.show()
    $("#other_step_submit").on "click", =>
      $("#other_step_submit") "href", "#final"


class TBank.Layout.Deposite extends TBank.Layout
  type: 'deposite'
  steps: [
    {view: TBank.StartForm, el: '#form-main-step'},
    {view: TBank.PersonalForm, el: '.questionnaire-step-block.step-1'},
    {view: TBank.ContactForm, el: '.questionnaire-step-block.step-2'}
    {view: TBank.Step4, el: '.questionnaire-step-block.step-3'}
    {view: TBank.FinalStepDeposit, el: "#maf_success"}
  ]

class TBank.Layout.Credit extends TBank.Layout
  type: 'credit'
  steps: [
    {view: TBank.StartForm, el: '#form-main-step'},
    {view: TBank.PersonalForm, el: '.questionnaire-step-block.step-1'},
    {view: TBank.ContactFormHomePhone, el: '.questionnaire-step-block.step-2'}
    {view: TBank.Step4Credit, el: '.questionnaire-step-block.step-3'}
    {view: TBank.FinalStepCredit, el: '#maf_success'}
  ]

class TBank.Layout.Transfer extends TBank.Layout
  type: "transfer"
  steps: [
    {view: TBank.StartForm, el: '#form-main-step'},
    {view: TBank.PersonalForm, el: '.questionnaire-step-block.step-1'},
    {view: TBank.ContactFormHomePhone, el: '.questionnaire-step-block.step-2'}
    {view: TBank.Step4Transfer, el: '.questionnaire-step-block.step-3'}
    {view: TBank.FinalStepTransfer, el: '#maf_success'}
  ]
  
class TBank.Layout.Business extends TBank.Layout
  type: "business"
  steps: [
    {view: TBank.StartBusiness, el: '#form-main-step'},
    {view: TBank.FinalBusiness, el: '.questionnaire-step-block.step-1'},
    {view: TBank.FinalStepBusiness, el: "#maf_success"}
  ]

class TBank.Layout.Pifanket extends TBank.Layout
  type: "pifanket"
  steps: [
    view: TBank.StartFormPif
    el: "#form-main-step"
  ,
    view: TBank.FinalStepDeposit
    el: "#maf_success"
  ]

class TBank.Layout.Buhsoft extends TBank.Layout
  type: "buhsoft"
  steps: [
    {view: TBank.BuhsoftStep, el: '#buhsoft-form'},
    {view: TBank.FinalStepBuhsoft, el: '#maf_success'}
  ]

class TBank.Layout.MTP extends TBank.Layout
  type: "mtp"
  steps: [
    {view: TBank.StartFormMTP, el: '#maf_full_form_main'},
    {view: TBank.FinalStepDeposit, el: '#maf_success'}
  ]

class TBank.Layout.CreditSpain extends TBank.Layout
  type: 'creditspain'
  steps: [
    {view: TBank.StartForm, el: '#form-main-step'},
    {view: TBank.PersonalForm, el: '#maf_full_form_main .step1'},
    {view: TBank.ContactFormHomePhone, el: '#maf_full_form_main .step2'}
    {view: TBank.Step4CreditSpain, el: '#maf_full_form_main .step3'}
    {view: TBank.FinalStepCredit, el: '#maf_success'}
  ]
