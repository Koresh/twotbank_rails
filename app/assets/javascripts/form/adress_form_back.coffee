window.TBank ?= {}

class AddressField

  model: {}

  constructor: (options) ->

    { @index, @key, @settings, @model } = options

    @$container = $ "##{@settings.name}"

    @parent_id = null

    @is_select2 = @settings.select2


  render: ->

    @addListeners()

    @addSelect2() if @is_select2

    @


  addSelect2: ->
    @$container.select2
      multiple: false
      selectOnBlur: true
      placeholder: @$container.attr "placeholder"
      minimumInputLength: @settings.minLength
      initSelection: (element, callback) =>
        id = element.val()
        #data = id: id
        TBank.Kladr['objectById'] id, (data) ->
          if data.results[0]
            callback data.results[0]


      query: (query) =>
          if @parent_id
            TBank.Kladr[@settings.method] query.term, @parent_id, (data) ->
              query.callback data
          else
            TBank.Kladr[@settings.method] query.term, (data) ->
              query.callback data


  addListeners: ->
    @model.on "change:#{@settings.name}", =>
      if @settings.enable
        @$container.trigger "field-has-changed", 
          key:    @key
          index:  @index
          value:  @getForParent()
        @clearError()
      else
        @$container.trigger "disabled-field-has-changed", 
          key:    @key
          index:  @index
          value:  @getForParent()


  setDefaults: ->
    if @getValue() isnt ""
      @$container.val def_value
      @doneField()
    @defaultEnabler()
    @

  getValue: ->
    $.trim @$container.val()

  getText: ->
    if @is_select2
      return $.trim @$container.select2("data").text
    else
      return $.trim @$container.val()

  setValue: (value) ->
    if @is_select2
      @$container.select2 "val", value
    else
      @$container.val value
    @$container.trigger "change"
    @

  getForParent: ->
    @$container.val()

  setParent: (value) ->
    @parent_id = value
    @

  getChildrenCount: ->
    @$container.select2("data").children_count

  getName: ->
    @settings.name

  doneField: ->
    @$container.trigger "field-is-done",
      key: @key
      index: @index

  defaultEnabler: ->
    if @settings.enable
      @enable()
    else
      @disable()
    @

  disable: ->
    @settings.enable = false
    @$container.attr("disabled","disabled").parents(".textfield").addClass("gray_bg").removeClass "textfieldError textfieldActive"
    @$container.trigger "field-disabled", name: @settings.name
    if @is_select2
      @$container.select2 "enable", false
    @

  enable: ->
    @settings.enable = true
    @$container.removeAttr("disabled").parents(".textfield").removeClass "gray_bg"
    @$container.trigger "field-enabled", name: @settings.name
    if @is_select2
      @$container.select2 "enable", true
    @

  isEnable: ->
    @settings.enable

  clear: ->
    if @is_select2
      @$container.select2 "val", ""
    else
      @$container.val ""
    @$container.trigger "change"
    @

  setFocus: ->
    if @is_select2
      @$container.select2 "open"
    else
      @$container.focus()
    @

  clearError: ->
    @$container.parents(".textfield").removeClass "textfieldError"




class AddressFieldset

  model: {}

  constructor: (options) ->

    { @model, suffix, @container}  = options

    @fields           = []

    @fields_settings  = @getDefaultFields suffix

    @forgot_check     = $ "#maf_#{suffix}_index_forgot"

    @setListeners()

    if suffix = "reg"
      @setSyncListeners()


    i = 0

    for key, obj of @fields_settings
      @fields[i] = new AddressField
        index: i
        key: key 
        settings: obj
        model: @model

      field = @fields[i].render()

      if ( field.getValue() isnt "" ) or field.isEnable() or ( @fields[i - 1].isEnable() and ( @fields[i - 1].getValue() isnt "" ) and ( $.trim( $("#maf_#{suffix}_street").val() ) is "" ) )
        field.enable()
        if i > 1
          parent_val = @fields[i - 1].getValue()
          field.setParent parent_val
      else
        field.disable()

      i++

    @setDefaults()


  workEnable: ->
    unless @forgot_check.is ":checked"
      @setEnable 0  

    @setEnable 1
    
    for i in [2..6]
      @setEnable(i) if @getValue(i)



  setDefaults: ->
    if @forgot_check.is ":checked"
        @fields[0].disable()
      else
        @fields[0].enable()



  setListeners: ->

    @forgot_check.on "change", (e) =>
      if $(e.target).is ":checked"
        @fields[0].disable()
      else
        @fields[0].enable()


    @container.on "field-is-done", (event, data)=>
      key = data.key
      @fields[key]
      #console.log "#{data.key} - FIELD IS DONE!"

    @container.on "field-has-changed", (event, data) =>    
      index = data.index
      value = data.value

      if index isnt 0

        max = @fields.length - 1

        #console.log "Field has changed - #{data.key}/#{index} max = #{max}"

        if ( index is 2 ) and ( ( @fields[2].getValue() is @fields[1].getValue() ) or ( @fields[2].getChildrenCount() is 0 ) )

          
          @fields[3].clear().disable()
          @fields[4].clear().setParent( value ).enable().setFocus()
          #@fields[3].clear().setParent( value ).enable()
          #@fields[4].clear().setParent( value ).enable()

          for i in [5..max]
            @fields[i].clear().disable() if @fields[i].isEnable()


        else

          if index < max

            #console.log "Setting parent value in - #{ value }"

            #if index < ( max - 1 )
            ###
            if index is 2

              @fields[3].clear().setParent( value ).enable().setFocus()
              @fields[4].clear().setParent( value ).enable()
              min = 5

            else
            ###

            @fields[index + 1].clear().setParent( value ).enable().setFocus()

            min = index + 2

          if index < ( max - 1 )

            for i in [min..max]

              @fields[i].clear().disable() if @fields[i].isEnable()


    @container.on "disabled-field-has-changed", (event, data) =>
      index = data.index
      value = data.value
      max = @fields.length - 1
      if ( index isnt 0 ) and ( index < max )
        @fields[index + 1].clear().setParent ( value )

    @


  setSyncListeners: ->

    @container.on "field-has-changed", (event, data) =>
      index = data.index
      @container.trigger "main-field-has-changed", index: index

    @

  getValue: (index) ->
    @fields[index].getValue()

  setValue: (index, value) ->
    @fields[index].setValue value


  getFullAddress: ->
    max = @fields.length - 1
    result = ""
    for i in [0..max]
      text = @fields[i].getText()
      if text isnt ""
        if i is max
          result = result + @fields[i].getText()
        else 
          result = result + @fields[i].getText() + ", "

    return result


  disableAll: ->
    max = @fields.length - 1
    for i in [0..max]
      @fields[i].disable()
    @

  setEnable: (index) ->
    @fields[index].enable()
    @

  getEnableAarray: ->
    array = []
    max = @fields.length - 1
    for i in [0..max]
      if @fields[i].isEnable()
        array.push i
    array

  getValueArray: ->
    array = []
    max = @fields.length - 1
    for i in [0..max]
      array.push @fields[i].getValue()
    array



  getDefaultFields: (suffix) ->
    defaults = 
      index:  
        name: "maf_#{suffix}_index"
        enable: true
        minLength:  6
        method: "infoByIndex"
        level: 0
        select2: false
      region: 
        name: "maf_#{suffix}_region"
        enable: true
        minLength:  3
        method: "regionsByLetters"
        level: 1
        select2: true
      city: 
        name: "maf_#{suffix}_city"
        enable:   false
        minLength:  3
        method: "areasByLettersAndParentId"
        dependent: "region"
        level: 2
        select2: true
      town: 
        name: "maf_#{suffix}_town"
        enable:   false
        minLength:  3
        method: "placesByLettersAndParentId"
        dependent: "city"
        level: 3
        select2: true
      street: 
        name: "maf_#{suffix}_street"
        enable:   false
        minLength:  3
        method: "streetsByLettersAndParentId"
        dependent: "town"
        level: 4
        select2: true
      house:  
        name: "maf_#{suffix}_house"
        enable:   false
        minLength:  1
        method: "housesByLettersAndParentId"
        dependent: "street"
        level: 5
        select2: false
      flat: 
        name: "maf_#{suffix}_flat"
        enable:   false
        minLength:  3
        method: "infoByIndex"
        dependent: "house"
        level: 6
        select2: false

    return defaults      



class TBank.AddressForm

  model: {}

  constructor: (options) ->

    { @container, @model, @is_sync, @suffix } = options

    @container = $ @container

    @flag_sync = false

    @render()

    @setListeners() if @is_sync


  render: ->

    if @is_sync

      @synck_checker = $ "#maf_same_address"

      @reg_address = new AddressFieldset
        model: @model
        suffix: "reg"
        container: @container.find ".reg-fieldset"

      @loc_address = new AddressFieldset
        model: @model
        suffix: "loc"
        container: @container.find ".loc-fieldset"

      
      @goSync() if @synck_checker.is ":checked"

    else

      if @suffix
        suffix = @suffix
      else
        suffix = "work"

      @work_adress = new AddressFieldset
        model: @model
        suffix: suffix
        container: @container.find ".#{suffix}-fieldset"


  setListeners: ->

    @synck_checker.on "change", =>
      if @synck_checker.is ":checked"
        @goSync()
      else
        @stopSync()

    @container.on "main-field-has-changed", (event, data) =>
      index = data.index
      if @flag_sync
        @loc_address.setValue index, @reg_address.getValue(index)

    @container.find("#maf_reg_index_forgot").on "change", =>
      if @flag_sync
        if $("#maf_reg_index_forgot").is ":checked"
          $("#maf_loc_index_forgot").attr("checked", "checked").parent().addClass "CFEcheckbox_checked"
        else
          $("#maf_loc_index_forgot").removeAttr("checked").parent().removeClass "CFEcheckbox_checked"



  goSync: ->
    @flag_sync = true
    @loc_address.disableAll()
    value_array = @reg_address.getValueArray()
    $("#maf_loc_index_forgot").attr "disabled", "disabled"

    if $("#maf_reg_index_forgot").is ":checked"
      $("#maf_loc_index_forgot").attr("checked","checked").parent().addClass "CFEcheckbox_checked"
    else
      $("#maf_loc_index_forgot").removeAttr("checked").parent().removeClass "CFEcheckbox_checked"

    for item, i in value_array
       @loc_address.setValue i, item


  stopSync: ->
    @flag_sync = false
    enable_array = @reg_address.getEnableAarray()
    $("#maf_loc_index_forgot").removeAttr "disabled"
    for item in enable_array
      @loc_address.setEnable item

  getLivingAddress: ->
    #console.log @loc_address.getFullAddress()
    @loc_address.getFullAddress()


  getRegisterAddress: ->
    #console.log @reg_address.getFullAddress()
    @reg_address.getFullAddress()

  disableWork: ->
    @work_adress.disableAll()
    $("#maf_work_index_forgot").attr "disabled", "disabled"

  enableWork: ->
    @work_adress.workEnable()
    $("#maf_work_index_forgot").removeAttr "disabled"



