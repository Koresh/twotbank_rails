var objDepositCalculator = {
    objPercents: {},
    objSummRates: {},
    objAddsummRates: {},
    objProperties: {
        'rur': {
            'ipad': [25000, 65000, '/images/calc_icon_ipad.png'],
            'mac': [80000, 450000, '/images/calc_icon_ipad.png'],
            'car': [750000, 2000000, '/images/calc_icon_ipad.png'],
            'yacht': [2500000, 5000000, '/images/calc_icon_ipad.png'],
            'house': [7000000, 20000000, '/images/calc_icon_ipad.png']
        },
        'usd': {
            'ipad': [780, 2030, '/images/calc_icon_ipad.png'],
            'mac': [2500, 14060, '/images/calc_icon_ipad.png'],
            'car': [23440, 62500, '/images/calc_icon_ipad.png'],
            'yacht': [78120, 156250, '/images/calc_icon_ipad.png'],
            'house': [218750, 625000, '/images/calc_icon_ipad.png']
        },
        'eur': {
            'ipad': [610, 1580, '/images/calc_icon_ipad.png'],
            'mac': [1950, 10970, '/images/calc_icon_ipad.png'],
            'car': [18300, 48780, '/images/calc_icon_ipad.png'],
            'yacht': [60980, 121950, '/images/calc_icon_ipad.png'],
            'house': [170730, 487800, '/images/calc_icon_ipad.png']
        }
    },
    arMonths: [],
    currency: 'rur',
    summ_num: 5,
    addsumm_num: 3,
    month_num: 4,
    calc_summ: 0,
    calc_addsumm: 0,
    calc_month: 0,
    calc_percent: 0,
    init: function(){
        this.objSummRates = depositCalculatorSummRates;
        this.objPercents = depositCalculatorPercents;
        this.arMonths = depositMonths;
        this.objAddsummRates = depositCalculatorAddsummRates;
        this.objProperties = depositCalculatorProperties;
        
        this.currency = $('#calc_select_currency').val();
        this.setCalcValues();
        this.calculate();
        this.initSliders();
        this.initCurrencyChange();
        this.initPercentageChange();

        this.calcHideShow();
        $(window).resize(function(e) {
            objDepositCalculator.calcHideShow();
        });
    },
    setCalcValues: function() {
        this.calc_summ = this.objSummRates[this.currency][this.summ_num];
        this.calc_addsumm = this.objAddsummRates[this.currency][this.addsumm_num];
        this.calc_month = this.arMonths[this.month_num];
        this.calc_percent = this.objPercents[this.currency][this.month_num];

        $('.summ_slider').addClass('hidden');
        $('.summ_slider.'+this.currency).removeClass('hidden');
        $('.addsumm_slider').addClass('hidden');
        $('.addsumm_slider.'+this.currency).removeClass('hidden');

        $('#calc_summ').html(this.formatNumbers(this.calc_summ));
        $('#calc_month').html(this.calc_month);
        $('#calc_percent').html(this.calc_percent + ' %');
        $('#calc_addsumm').html(this.formatNumbers(this.calc_addsumm));
    },
    calculate: function() {
        var period = 300;

        var totalSummSavePercent, totalSummTakePercent, totalSavePercent, totalTakePercent, tmpSavePercent, tmpTakePercent, percent;
        totalSummSavePercent = totalSummTakePercent = objDepositCalculator.calc_summ;
        totalSavePercent = totalTakePercent = tmpSavePercent = tmpTakePercent = 0;
        percent = Math.round(parseFloat(objDepositCalculator.calc_percent.replace(',', '.')) * 100 / 12) / 100;

        for (i=1; i<=objDepositCalculator.calc_month; i++) {
            tmpSavePercent = Math.round(totalSummSavePercent * percent / 100);
            totalSavePercent += tmpSavePercent;
            totalSummSavePercent += tmpSavePercent;

            tmpTakePercent = Math.round(totalSummTakePercent * percent / 100);
            totalTakePercent += tmpTakePercent;

            if (i != objDepositCalculator.calc_month) {
                totalSummSavePercent += objDepositCalculator.calc_addsumm;
                totalSummTakePercent += objDepositCalculator.calc_addsumm;
            }
        }

        var totalSumm, depositSumm, depositPercents;
        depositSumm = objDepositCalculator.calc_summ + objDepositCalculator.calc_addsumm * (objDepositCalculator.calc_month - 1);
        if ($('#hold_percent_y').is(':checked')) {
            totalSumm = totalSummSavePercent;
            depositPercents = totalSavePercent;
        } else {
            totalSumm = totalSummTakePercent + totalTakePercent;
            depositPercents = totalTakePercent;
        }

        var property, propertyHTML;
        for (property in objDepositCalculator.objProperties[objDepositCalculator.currency]) {
            if (totalSumm <= objDepositCalculator.objProperties[objDepositCalculator.currency][property][1]) {
                break;
            }
        }
        propertyHTML = '<div class="Img"><img src="' + objDepositCalculator.objProperties[objDepositCalculator.currency][property][2] + '" alt="" /></div>';
        //propertyHTML += '<p class="text2"><span>или</span> ' + Math.round(totalSumm / objDepositCalculator.objProperties[objDepositCalculator.currency][property][0]) + '&nbsp;' + property + '</p>';
        propertyHTML += '<h2 class="text2"><span class="blue">это примерно</span> ' + objDepositCalculator.formatNumString(Math.round(totalSumm / objDepositCalculator.objProperties[objDepositCalculator.currency][property][0]), objDepositCalculator.objProperties[objDepositCalculator.currency][property][3]) + '</h2>';
        
        
        $('#calc_total_sum').animate({top: '+=63px'}, period, function(){
            $('#calc_total_sum').html(objDepositCalculator.formatNumbers(totalSumm) + ' ' + objDepositCalculator.currency.toUpperCase())
                .animate({top: '-=63px'}, period);
        });
        $('#deposit_receipt_b').animate({top: '-=160px'}, period, function(){
            $('#calc_total_vklad').html(objDepositCalculator.formatNumbers(depositSumm) + ' ' + objDepositCalculator.currency.toUpperCase());
            $('#calc_total_percent').html(objDepositCalculator.formatNumbers(depositPercents) + ' ' + objDepositCalculator.currency.toUpperCase());
            $('#calc_total_month_2').html(objDepositCalculator.calc_month + ((objDepositCalculator.calc_month>4)?' месяцев':' месяца'));
            $('#deposit_receipt_b').animate({top: '+=160px'}, period);
        });

        $('#calc_total_month').fadeOut(period, function(){
            $(this).html(objDepositCalculator.calc_month + ((objDepositCalculator.calc_month>4)?' месяцев':' месяца'))
                .fadeIn(period);
        });
        $('#calc_property').fadeOut(period, function(){
            //if ($.browser.safari) period = 600;
            $(this).html(propertyHTML)
                .fadeIn(period);
        });
    },
    initSliders: function(){
        // $("#slider1").slider({
        //     range: "min",
        //     tooltips: true,
        //     value: objDepositCalculator.summ_num,
        //     min: 0,
        //     max: objDepositCalculator.objSummRates[objDepositCalculator.currency].length-1,
        //     step: 1,
        //     slide: function(event, ui) {
        //         objDepositCalculator.summ_num = ui.value;
        //         objDepositCalculator.calc_summ = objDepositCalculator.objSummRates[objDepositCalculator.currency][ui.value];
        //         $('#calc_summ').html(objDepositCalculator.formatNumbers(objDepositCalculator.calc_summ));
        //     },
        //     stop: function(event, ui) {
        //         objDepositCalculator.calculate();
        //     }
        // });

        // $("#slider2").slider({
        //     range: "min",
        //     tooltips: true,
        //     value: objDepositCalculator.month_num,
        //     min: 0,
        //     max: objDepositCalculator.arMonths.length-1,
        //     step: 1,
        //     slide: function(event, ui) {
        //         objDepositCalculator.month_num = ui.value;
        //         objDepositCalculator.calc_month = objDepositCalculator.arMonths[ui.value];
        //         objDepositCalculator.calc_percent = objDepositCalculator.objPercents[objDepositCalculator.currency][ui.value];
        //         $('#calc_month').html(objDepositCalculator.arMonths[ui.value]);
        //         $('#calc_percent').html(objDepositCalculator.calc_percent + ' %');
        //     },
        //     stop: function(event, ui) {
        //         objDepositCalculator.calculate();
        //     }
        // });

        // $("#slider3").slider({
        //     range: "min",
        //     tooltips: true,
        //     value: objDepositCalculator.addsumm_num,
        //     min: 0,
        //     max: objDepositCalculator.objAddsummRates[objDepositCalculator.currency].length-1,
        //     step: 1,
        //     slide: function(event, ui) {
        //         objDepositCalculator.addsumm_num = ui.value;
        //         objDepositCalculator.calc_addsumm = objDepositCalculator.objAddsummRates[objDepositCalculator.currency][ui.value];
        //         $('#calc_addsumm').html(objDepositCalculator.formatNumbers(objDepositCalculator.calc_addsumm));
        //     },
        //     stop: function(event, ui) {
        //         objDepositCalculator.calculate();
        //     }
        // });
    },
    initCurrencyChange: function(){
        $('#calc_select_currency').change(function(){
            objDepositCalculator.currency = $(this).val();
            $(this).children().each(function(){
                if ($(this).is(':selected') && $(this).val()!=objDepositCalculator.currency) {
                    objDepositCalculator.currency = $(this).val();
                }
            });
            objDepositCalculator.setCalcValues();
            objDepositCalculator.calculate();
        });
    },
    initPercentageChange: function(){
        $('input[name="calc_hold_percent"]').on('change', function(){
            objDepositCalculator.calculate();
        });
    },
  calcHideShow: function(){
    if($('body').width() < 480){
      $('div.calculator').hide();
    }
    else{
      $('div.calculator').show();
    }
  },
    formatNumbers: function(num){
        return num.toString().replace(/(\d)(?=(\d\d\d)+([^\d]|$))/g, '$1 ');
    },
    formatNumString: function(num, strings){
        var cases = [2, 0, 1, 1, 1, 2];  
        return num + '&nbsp;' + strings[ (num%100>4 && num%100<20)? 2 : cases[(num%10<5) ? num%10 : 5] ];  
    }
};

$(function() {
    objDepositCalculator.init();
});