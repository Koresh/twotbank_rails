window.TBank ?= {}
class TBank.App

  class Router extends Backbone.Router
    routes:
        #'': 'first_form'
        'step:page': 'gotoStep'
        'final': 'gotoFinalStep'
        'maf_close_form': "close_confirm"


    close_confirm: ->

      new TbWidgets.FormClosing =>
        questView.clearLayout()
        #@navigate "step1", trigger: true
      , =>
        questView.stayOnCurrent()


    gotoFinalStep: ->
      questView.gotoFinalStep()


    gotoStep: (step) ->

      #console.log "Form №#{step}"

      step = step * 1

      questView.gotoStep step

      $("#teaser_short").trigger "click" if step is 1


  layouts:
    deposite: TBank.Layout.Deposite
    credit: TBank.Layout.Credit
    creditspain: TBank.Layout.CreditSpain
    transfer: TBank.Layout.Transfer
    business: TBank.Layout.Business
    pifanket: TBank.Layout.Pifanket
    buhsoft: TBank.Layout.Buhsoft
    mtp: TBank.Layout.MTP

  constructor:(el) ->
    form_type = $(el).attr('data-form-type')
    #console.log @layouts[form_type]
    if form_type isnt ""
      window.questView = new @layouts[form_type] el: el, current_step: 1
      questView.render()
      window.router = new Router


  start: ->
    Backbone.history.start()
