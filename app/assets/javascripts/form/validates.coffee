window.Validates = window.Validates || {}

# For IE8 and earlier version.
if not window.Date.now 
  window.Date.now = ->
    return new window.Date().valueOf()

class Validates.Base

  valid: (value) ->
    @regular.test value



class Validates.Required

  valid: (value) ->
    if ( $.trim(value) isnt '' ) && value
      return true
    else
      return false

class Validates.Fiasid extends Validates.Base
  regular: /^[\d\w-]{36}$/

class Validates.Email extends Validates.Base
  regular: /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/

class Validates.Name extends Validates.Base
  regular: /^[а-яА-ЯёЁ\s-]{2,}$/

class Validates.Phone extends Validates.Base
  regular: /^\+\d\s\([\d]{3}\)\s[\d]{3}\-[\d]{2}\-[\d]{2}$/

class Validates.Spainphone extends Validates.Base
  regular: /^(\+\d\d\s\d{9})*$/

class Validates.Date extends Validates.Base
  regular: /^[\d]{2}\.[\d]{2}\.[\d]{4}$/

  valid: (value)->
    if @regular.test value
      [day, month, year] = value.split('.')
      start = new window.Date(1900,0,1).getTime()
      odate = new window.Date(year, month-1, day)
      date = odate.getTime()
      end = new window.Date(2050,0,1).getTime()
      if date > start && date < end && day*1 is odate.getDate() && month-1 is odate.getMonth()
        true
      else
        false
    else
      false

class Validates.Datepif extends Validates.Base
  regular: /^[\d]{2}\.[\d]{2}\.[\d]{4}$/

  valid: (value)->
    if @regular.test value
      [day, month, year] = value.split('.')

      start = new window.Date(window.Date.now()).getTime()
      date  = new window.Date(year, month-1, day).getTime()
      end   = new window.Date(2013,7,1).getTime()

      if ( date < end ) and ( date >= start )
        true
      else
        false

    else
      false


class Validates.Country extends Validates.Base
  regular: /^[а-яА-ЯёЁ\,\s]{3,}[\s\,а-яА-ЯёЁ]+$/

class Validates.Latinname extends Validates.Base
  regular: /^[a-zA-Z-]{3,}(\s[a-zA-Z-]{2,})+$/

class Validates.Pasportseria extends Validates.Base
  regular: /^[\d]{2}-?\s?[\d]{2}$/

class Validates.Pasportnumber extends Validates.Base
  regular: /^\d{6}$/

class Validates.Pasportcode extends Validates.Base
  regular: /^\d{3}-?\d{3}$/

class Validates.Simpletext extends Validates.Base
  regular: /^[а-яА-ЯёЁ№0-9,\.\'\"\-\«\»\—\s]{3,}$/

class Validates.Commontext extends Validates.Base
  regular: /^[a-zA-Zа-яА-ЯёЁ№0-9,\.\'\"\-\«\»\—\s]{3,}$/

class Validates.Anytext extends Validates.Base
  regular: /^.{3,}$/

class Validates.Address extends Validates.Fiasid

class Validates.Addressnum extends Validates.Base
  regular: /^[а-яА-Яa-zA-Z\/\(\)\s-,0-9]{1,}$/

class Validates.Number extends Validates.Base
  regular: /^\d{1,}$/

class Validates.Codeword extends Validates.Base
  regular: /^[а-яА-Я]{3,}$/

class Validates.Checkcode extends Validates.Base
  regular: /^\d{5}$/
