var objAddresses = {
    init: function() {
        this.tableResize();
        this.tableRefresh();
        this.scrollToMap();
    },
    tableResize: function() {
        $(window).resize(function(e) {
            objAddresses.tableRefresh();
        });
    },
    tableRefresh: function() {
        if ($('body').width() < 700) {
            $('#contacts-offices table.tableNormal').hide();
            $('#contacts-offices table.tableMin').show();
        } else {
            $('#contacts-offices table.tableNormal').show();
            $('#contacts-offices table.tableMin').hide();            
        }
    },
    scrollToMap: function() {
        $('#contacts-offices a').click(function(e) {
            e.preventDefault();
            $('html, body').animate({
                scrollTop: $('#map-type').offset().top
            });
            
            cityId = $(this).attr('data-city-id');
            cityOption = $('#change-city-map option[value = ' + cityId + ']');
            index = $('#change-city-map option').index(cityOption);

            $('#change-city-map option').removeAttr('selected');
            cityOption.attr('selected', 'selected');
            
            $('#change-city-map').siblings('div.CFEselectListContainer')
                                 .find('div.CFEselectListItem')
                                 .removeClass('CFEselectedItem');

            $('#change-city-map').siblings('div.CFEselectListContainer')
                                 .find('div.CFEselectListItem')
                                 .eq(index)
                                 .trigger('click');
        });
    }
};

$(function() {
    objAddresses.init();
});