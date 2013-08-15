window.TBank ?= {}


class TBank.Layout extends Backbone.View
  steps:[]
  views: []
  current_step: 1
  product: ''
  type: 'deposite'

  events:
    "click #first_step_submit" : "toSecondStep"
    "click #business_account_submit" : "toSecondStep"


  toSecondStep:  ->
    router.navigate "step2", trigger: true


  initialize: ->
    @product = $('#product').val() || @product
    @sendmodel ||= new TBank.SendModel
    @api = new TBank.Api @type, @product

    @prev_step = 0

    @api.getUniqID (uniqID)=>
      @sendmodel.set 'id', uniqID
      @sendmodel.set 'product_url', document.location.href
      @sendmodel.set 'product', @product

    for step, index in @steps
      step = new step['view'] el: step['el'], sendmodel: @sendmodel, api: @api, step_num: index + 1
      @views.push step.render()


    @step_count = @views.length

    @


  render: ->
    @afterRender()
  afterRender: ->

  afterGotoStep: ->
    @views[@current_step-1].afterGotoStep()
    @updateAnalytics "#step#{@current_step}"

  updateAnalytics: (label) =>
      yaCounter10379614.reachGoal(@sendmodel.get('product_url') + label);
      _gaq.push(['_setCustomVar', 1, 'uniqId', @sendmodel.get('uniqID'), 1]);
      _gaq.push(['_setCustomVar', 2, 'formType', @type, 2]);
      _gaq.push(['_setCustomVar', 3, 'formStep', label, 2]);
      _gaq.push(['_trackPageview', @sendmodel.get('product_url') + label]);


  gotoFinalStep: =>
    @gotoStep @step_count

  gotoStep: (step) =>

    #console.log "from #{@current_step} to #{step}"

    if step > @current_step

      @cascadCommit step, @current_step
      ###
      @commitStep @current_step, (status) =>
        if status

          @stepMove step
          @afterGotoStep()

        else
          @stayOnCurrent()
      ###

    else if step < @current_step
      @stepMove step
    

    else
      @stayOnCurrent()


  cascadCommit: (step,current_step) ->

    @commitStep current_step, (status) =>
      #console.log "COMMIT STATE IS #{status}"
      if status
        #console.log "from #{step} to #{current_step}"
        if ( step - current_step ) is 1    

          @stepMove step
          @afterGotoStep()

        else

          current_step = current_step + 1
          @current_step = current_step - 1

          @cascadCommit step, current_step

      else
        @stayOnCurrent()


  stepMove: (step) ->
    
    @prev_step    = @current_step
    @current_step = step

    #console.log "from #{@prev_step} to #{@current_step}"


    @views[@prev_step - 1].closeStep =>
      @views[@current_step - 1].openStep @step_count, =>
        @scrollToEl "#maf_full_form"

    @setProgressbar( @current_step ) if @current_step isnt @step_count
    @render()


  stayOnCurrent: ->
    @current_step = 1 if @current_step < 1
    #console.log "Stay on current step!"
    router.navigate "step#{ @current_step }", trigger: false

    if @$el.find(".textfieldError, .selectfieldError").first().length
      @scrollToEl @$el.find(".textfieldError, .selectfieldError").first(), 10
    else if $("#one_checkbox_valid").length 
      @scrollToEl $("#one_checkbox_valid"), 10




  scrollToEl: (element, topMargin, callback) ->
    $element = $(element)
    if $element.length
      topMargin ?= 0

      headHeight =
      if $('.head .tBlock').css('position') is 'fixed'
        $('.head .tBlock').height()
      else
        0

      topPx = $(element).offset().top - headHeight - topMargin
      $('body, html').animate scrollTop: topPx, 'slow', =>
        callback() if typeof(callback) is "function"
    else
      callback() if typeof(callback) is "function"


  commitStep: (step, callback) ->
    @views[step - 1].commit(callback)


  setProgressbar: (step) ->

    if step isnt @step_count

      step_width = 235*3 / (@step_count - 2)

      p_width = 75 + step_width * ( step - 1 )

      $(".switcher .progress").animate width: p_width , "slow" , ->
          $(".switcherBlock").find(".item").removeClass("activeSwitcher").eq(step - 1).addClass "activeSwitcher"


  clearLayout: ->
    #console.log "Layout has been cleaned!!!"
    for view in @views[0..@views.length-2]
      view.clear()
    document.location = document.location.pathname



class TBank.StepView extends Backbone.View

  _modelBinder: undefined

  events: =>
    _.extend {"change input[type='text']":"trimField"}, @originalEvents, @additionalEvents

  trimField: (e)->
    target = $ e.target
    target.val $.trim(target.val())

  initialize:(options) ->

    @model = new @_model

    #console.log @model.toJSON()

    @disabledHash = []

    @api = options.api
    @sendmodel = options.sendmodel
    @sendmodel.save_step(@model)
    @step_num = options.step_num

    _.bindAll @
    @_modelBinder = new Backbone.ModelBinder

  render: ->

    #console.log "Rendring view", @model.toJSON()

    @_modelBinder.bind @model, @el


    for key of @model.attributes
      if mask = @model.getMask key
        eval "new Masks.#{mask.capitalize()}( $('##{key}') )"

    @afterRender()

    @


  afterRender: ->

  afterGotoStep: ->

  clear: ->
    @model.set 'id', 1
    @model.destroy()
    @model = new @_model
    @_modelBinder.bind @model, @el

  commit:(callback) ->
    if @validate()
      @stepvalidate (status) =>
        if status
          @model.save()
          @sendmodel.save_step(@model)
          @afterCommit()
          #console.log "@sendmodel", @sendmodel
        callback status
    else
      callback false

    updateAnalytics: (label) =>
        yaCounter10379614.reachGoal(@sendmodel.get('requestUri') + label);
        _gaq.push(['_setCustomVar', 1, 'uniqId', @sendmodel.get('uniqID'), 1]);
        _gaq.push(['_setCustomVar', 2, 'formType', 'account', 2]);
        _gaq.push(['_setCustomVar', 3, 'formStep', label, 2]);
        _gaq.push(['_trackPageview', this.requestUri + label]);

  afterCommit: ->

  stepvalidate:(callback) ->
    callback(true)

  validate: ->
    valid = true
    #console.log @model.toJSON()
    for key of @model.attributes
        valid = @validatefield(key) && valid
    valid


  validatefield: (key)->
    valid = true
    value = @model.get key

    #console.log "#{key}-field in VALIDATION"

    if not @isDisabled key
      validators = @model.getValidators key
      for validator in validators
          validator = eval "new Validates.#{validator.capitalize()}"
          valid &&= validator.valid(value)

          #console.log "#{key}-field value is #{value}"
          #console.log "#{key}-field valid is #{valid}"

          if valid
            @clearError(key)
          else
            @setError(key)
    else
      #console.log "#{key}-field is DISABLED HASH"
      @clearError(key)
    valid

  isDisabled: (key) ->
    _.indexOf(@disabledHash, key) > -1

  setError: (key) ->

    $label  = $("##{key}_label")

    if $label.length

      $label.addClass "accessError"

    else
      $parent = $("##{key}").parent()
      if $parent.hasClass "CFEselect"
        $parent.addClass "selectfieldError"
      else
                                          #КОСТЫЛЬ!
        $parent.addClass("textfieldError").nextAll(".error").show()

  clearError: (key) ->

    $label  = $("##{key}_label")

    if $label.length

      $label.removeClass "accessError"

    else                                                                  #КОСТЫЛЬ!
      $("##{key}").parent().removeClass('textfieldError selectfieldError').nextAll(".error").hide()

  openStep: (step_count, callback) ->
    @$el.show()
    if @step_num is step_count - 1
      $("#other_step_submit").attr "href", "#final"
    else
      $("#other_step_submit").attr "href", "#step#{@step_num + 1}"
    $("#prev_step_submit").attr "href", "#step#{@step_num - 1}"
    $("#maf_full_form").slideDown 150, =>
      callback() if typeof( callback ) is "function"

  afterOpen: ->


  closeStep: (callback) ->
    $("#maf_full_form").slideUp 150, =>
      @$el.hide()
      callback() if typeof( callback ) is "function"
