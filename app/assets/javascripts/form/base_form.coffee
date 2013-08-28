window.TBank = window.TBank || {}
TBank.cookieSync = (method, model, options) ->
  $.cookie.json = true
  #model_name = Object.getPrototypeOf(model).constructor.name
  model_name = model.cookie_name
  switch method
    when 'read'
      attributes = $.cookie model_name
      if attributes
          model.attributes = attributes
    when 'create'
      $.cookie model_name, model.toJSON()
    when 'delete'
      $.removeCookie(model_name)

class Backbone.Form extends Backbone.Model
    schema: {}
    defaults: ->
        attributes = {}
        for key of @schema
            attributes[key] = @schema[key]['defaults'] || ''
        attributes

    initialize:(options) ->
        @.fetch()

    getValidators:(key) ->
        validators = []
        validators = @schema[key]['validators'] if @schema[key]
        validators

    getDependents: (key)  ->
        @schema[key]["dependent_keys"] if @schema[key]

    getMask: (key) ->
        @schema[key]["mask"] if @schema[key]

    sync: ->
        TBank.cookieSync.apply @, arguments


