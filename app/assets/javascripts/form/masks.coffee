window.Masks = window.Masks || {}
window.Placeholders = window.Placeholders || {}

class Masks.Base

  constructor: ($el) ->
    $el.mask @mask

    $el.on "blur", ->
      Placeholders.enable( this )

class Masks.Phone extends Masks.Base
  mask: "+7 (999) 999-99-99"

class Masks.Date extends Masks.Base
  mask: "99.99.9999"

class Masks.Pasportseria extends Masks.Base
  mask: "9999"

class Masks.Year extends Masks.Pasportseria

class Masks.Pasportcode extends Masks.Base
  mask: "999-999"

class Masks.Pasportnumber extends Masks.Base
  mask: "999999"
class Masks.Postindex extends Masks.Base
  mask: "999999"

class Masks.Datepif extends Masks.Base
  mask: "99.99.2013"
