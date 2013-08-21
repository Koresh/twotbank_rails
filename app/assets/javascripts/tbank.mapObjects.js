var objMapObjects = {
    mapViewFull: false,
    init: function(){
        this.initAdaptive();
        this.changeMapBoxSize();
        // cash in out pages
        if ($('.map.map-cash-in-out').length > 0) {
            this.checkCurrentCityId();
            this.changeTypeMarkers();
        }
        // contacts pages
        if ($('.map.map-contacts').length > 0) {
            this.contactsCheckCurrentCityId();
//            this.contactsChangeTypeMarkers();
            this.contactsChangeCity();
        }

        $(window).resize(function(e) {
            objMapObjects.initAdaptive();
        });
        
        $('#searchAdress').example('ул. Толстого');
    },
    initAdaptive: function(){
            if($('body').width() < 640) {
                $('.map .searchBlock').hide();
            } else {
                $('.map .searchBlock').show();
            }
            // google maps
            google.maps.event.trigger(googlemap.map, "resize");
            googlemap.map.panTo(googlemap.latlngCenter);
    },
    checkCurrentCityId: function(){
        if (mapConfig.currentCity.id != null || mapConfig.currentCity.id != undefined) {
            if ($('#all-offices').length > 0) {
                $('#all-offices').addClass('active');
                setTimeout(function(){
                    markers.getOffices(mapConfig.currentCity.id, 'all');
                }, 800);
            } else if ($('#cash-ins').length > 0) {
                $('#cash-ins').addClass('active');
                setTimeout(function(){
                    markers.getTerminals(mapConfig.currentCity.id);
                }, 100);
            }

            // fix resize map
            if ($('.map.map-cash-in-out').length > 0) {
                $('#map-box-resize').addClass('jsClick').click().removeClass('jsClick');
            }
        }
    },
    changeTypeMarkers: function(){
        //
        $('#all-offices').click(function(){
            $('#map-type a.active').removeClass('active');
            $(this).addClass('active');
            markers.deleteMarkers();
            markers.getOffices(mapConfig.currentCity.id, 'all');
            return false;
        });
        //
        $('#bank-offices').click(function(){
            $('#map-type a.active').removeClass('active');
            $(this).addClass('active');
            markers.deleteMarkers();
            markers.getOffices(mapConfig.currentCity.id, 'bank');
            return false;
        });
        //
        $('#cash-ins').click(function(){
            $('#map-type a.active').removeClass('active');
            $(this).addClass('active');
            markers.deleteMarkers();
            markers.getTerminals(mapConfig.currentCity.id);
            return false;
        });
    },
    contactsCheckCurrentCityId: function(){
        if (mapConfig.currentCity.id != null || mapConfig.currentCity.id != undefined) {
//            if ($('#contacts-all-offices').length > 0) {
//                $('#contacts-all-offices').addClass('active');
                setTimeout(function(){
                    markers.getOffices(mapConfig.currentCity.id, 'bank', function(offices){
                        var cnt = offices.length;
                        $('#office-string-cnt').text(objMapObjects.stringCnt(cnt, 'офис', ['', 'а', 'ов']));
                    });
                }, 100);
//            }
        }
    },
    contactsChangeTypeMarkers: function(){
        //
        $('#contacts-all-offices').click(function(){
            $('#map-type a.active').removeClass('active');
            $(this).addClass('active');
            markers.deleteMarkers();
            markers.getOffices($('#change-city-map option:selected').val(), 'all', function(offices){
                        var cnt = offices.length;
                        $('#office-string-cnt').text(objMapObjects.stringCnt(cnt, 'офис', ['', 'а', 'ов']));
                    });
            return false;
        });
        //
        $('#contacts-bank-offices').click(function(){
            $('#map-type a.active').removeClass('active');
            $(this).addClass('active');
            markers.deleteMarkers();
            markers.getOffices($('#change-city-map option:selected').val(), 'bank', function(offices){
                        var cnt = offices.length;
                        $('#office-string-cnt').text(objMapObjects.stringCnt(cnt, 'офис', ['', 'а', 'ов']));
                    });
            return false;
        });
    },
    contactsChangeCity: function(){
        //
        $('#change-city-map').change(function(){
            var type = 'bank';
//            if ($('#contacts-bank-offices').hasClass('active')) {
//                type = 'bank';
//            }
            markers.deleteMarkers();
            markers.getOffices($('#change-city-map option:selected').val(), type, function(offices){
                var cnt = offices.length;
                $('#office-string-cnt').text(objMapObjects.stringCnt(cnt, 'офис', ['', 'а', 'ов']));
            });
            googlemap.latlngCenter = new google.maps.LatLng(parseFloat($('#change-city-map option:selected').attr('lat')), parseFloat($('#change-city-map option:selected').attr('lng')) + googlemap.lngOffset);
            
            return false;
        });
    },
    changeMapBoxSize: function(){
        $('#map-box-resize').toggle(
            function(){
                $(this).addClass('up');

                // scroll map top
                if (!$(this).hasClass('jsClick')) {
                    var scrollTop = $('#map').offset().top - $('.head .tBlock').outerHeight() - 10;
                    // scroll page
                    $('html, body').stop().animate({
                            'scrollTop': scrollTop
                    }, 500, 'swing');
                }
                var mapBoxHeight = $(window).height() - $('.head .tBlock').outerHeight() - 20;
                // resize map
                $('#map').animate({
                        height: mapBoxHeight
                    }, 500, 'swing', function() {
                        // trigger resize
                        google.maps.event.trigger(googlemap.map, "resize");
//                        googlemap.map.panTo(googlemap.latlngCenter);
                        // fit bounds
                        if (typeof(googlemap.fitBounds) == "function") {
                            googlemap.fitBounds();
                        } 
                        objMapObjects.mapViewFull = true;
                });
            },
            function(){
                $(this).removeClass('up');
                $('#map').animate({
                        height: googlemap.firstMapBoxHeight
                    }, 500, 'swing', function() {
                        google.maps.event.trigger(googlemap.map, "resize");
//                        googlemap.map.panTo(googlemap.latlngCenter);
                        // fit bounds
                        if (typeof(googlemap.fitBounds) == "function") {
                            googlemap.fitBounds();
                        } 
                        objMapObjects.mapViewFull = false;
                        markers.closeInfoBubble();//hide the infobubble
                });
            }
        );
    },
    stringCnt: function(cnt, string, suffixArr){
        var number = Math.abs(cnt);
        number %= 100;
        if (number >= 5 && number <= 20) {return cnt + ' ' + string + suffixArr[2];}
        number %= 10;
        if (number == 1) {return cnt + ' ' + string + suffixArr[0];}
        if (number >= 2 && number <= 4) {return cnt + ' ' + string + suffixArr[1];}

        return cnt + ' ' + string + suffixArr[2];
    }
};

/**
 * Google maps
 */
var googlemap = {
    map: {},
    lat: 55.749531,
    lng: 37.6161,
    lngOffset: 0.04,
    zoom: 11,
    latlngCenter: {},
    firstMapBoxHeight: 242,
    init: function() {
        if (mapConfig.currentCity.lat != undefined && mapConfig.currentCity.lng != undefined) {
            googlemap.lat = mapConfig.currentCity.lat;
            googlemap.lng = mapConfig.currentCity.lng;
        }
        
        var latlng = new google.maps.LatLng(googlemap.lat, googlemap.lng + googlemap.lngOffset);
        googlemap.latlngCenter = new google.maps.LatLng(googlemap.lat, googlemap.lng + googlemap.lngOffset);
        googlemap.firstMapBoxHeight = $('#map').outerHeight();
        var mapType = googlemap.mapType('ROADMAP');
        var options = {
            zoom: parseInt(googlemap.zoom),
            center: latlng,
            panControl: false,
            streetViewControl: false,
            zoomControl: true,
            zoomControlOptions: {
                style: google.maps.ZoomControlStyle.SMALL,
                position: google.maps.ControlPosition.LEFT_TOP
            },  
            mapTypeControl: false,
//            mapTypeControlOptions: {
//                mapTypeIds: [google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.HYBRID],
//                style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
//                position: google.maps.ControlPosition.LEFT_TOP
//            },                       
            scaleControl: false,
            scrollwheel: false,
            mapTypeId: mapType
        };
        googlemap.map = new google.maps.Map(document.getElementById("map"), options);
        googlemap.map.mapTypes.set('2tStyle', new google.maps.StyledMapType([{stylers: [{saturation: -100}]}], {name: "Grayscale Map"}));
        googlemap.map.setMapTypeId('2tStyle');

        markers.init(googlemap.map, latlng);
        
        // search
        googlemap.searchAddressEvents();
    },
    mapType: function(maptype){
        var mapTypeObj;
        switch(maptype){
            case 'ROADMAP':
                mapTypeObj = google.maps.MapTypeId.ROADMAP;
                break;
            case 'SATELLITE':
                mapTypeObj = google.maps.MapTypeId.SATELLITE;
                break;
            case 'TERRAIN':
                mapTypeObj = google.maps.MapTypeId.SATELLITE;
                break;
            case 'HYBRID':
                mapTypeObj = google.maps.MapTypeId.HYBRID;
                break;
            default:
                mapTypeObj = google.maps.MapTypeId.ROADMAP;
                break;
        }
        return mapTypeObj;
    },
    searchAddressEvents: function() {
        // enter
        $('#searchAdress').on('keyup', function(e){
            if (e.keyCode == 13) {
                googlemap.searchAddress();
            }
        });
        // serach button
        $('#searchOnMap').click(function(){
            googlemap.searchAddress();
        });
    },
    searchMarker: {},
    searchAddress:  function() {
        if (googlemap.searchMarker instanceof google.maps.Marker) {
            googlemap.searchMarker.setMap(null);
        }

        var geocoder = new google.maps.Geocoder;
        var address = $('#searchAdress').val();
        if ($('#searchAdress').hasClass('example') || address.length < 3) {
            return;
        }

        // cash in/out pages
        if ($('#city-site-link').length > 0) {
            address = $('#city-site-link').text() + ' ' + address;
        }

        // contacts page
        if ($('#change-city-map').length > 0) {
            address = $('#change-city-map option:selected').text() + ' ' + address;
        }

        geocoder.geocode({address: address}, function(results, status) {
          if (status == google.maps.GeocoderStatus.OK) {
            googlemap.map.panTo(results[0].geometry.location);
            var image = new google.maps.MarkerImage(markers.views.search.marker,
                new google.maps.Size(26, 42),
                new google.maps.Point(0,0),
                new google.maps.Point(13, 42)
            );
            var shadow = new google.maps.MarkerImage(markers.views.search.shadow,
                new google.maps.Size(34, 15),
                new google.maps.Point(0,0),
                new google.maps.Point(2, 15)
            );
            googlemap.searchMarker = new google.maps.Marker({
                position: results[0].geometry.location,
                animation: google.maps.Animation.DROP,
                map: googlemap.map,
                shadow: shadow,
                icon: image
            });
            googlemap.map.setZoom(Math.max(16, googlemap.map.getZoom()));
          } else {
            alert("Не удалось найти точку на карте с таким адресом");
          }
          
          googlemap.latlngCenter = results[0].geometry.location;

        });
    },
    fitBounds: function(){
        var bounds = new google.maps.LatLngBounds();
        if (markers.markersArray) {
            for (i in markers.markersArray) {
                bounds.extend(markers.markersArray[i].getPosition());
            }
        }
        var zoomChangeBoundsListener = google.maps.event.addListener(googlemap.map, 'bounds_changed', function(event) {
            google.maps.event.removeListener(zoomChangeBoundsListener);
            var zoom = Math.max(10, googlemap.map.getZoom());
            if (zoom > 16) {
                zoom = Math.min(15, googlemap.map.getZoom())
            }
            googlemap.map.setZoom(zoom);
        });
        googlemap.map.fitBounds(bounds);
    } 
    
}

/**
 * Markers
 */
var markers = {
    infobubble: {},
    markersArray: [],
    views: {
        cashin: {
            marker: '/static/images/mapIcons/map_icon_cashin.png',
            shadow: '/static/images/mapIcons/map_icon_cashin_shadow.png'
        },
        office: {
            marker: '/static/images/mapIcons/map_icon_office.png',
            shadow: '/static/images/mapIcons/map_icon_office_shadow.png'
        },
        partner: {
            marker: '/static/images/mapIcons/map_icon_partner.png',
            shadow: '/static/images/mapIcons/map_icon_partner_shadow.png'
        },
        search: {
            marker: '/static/images/mapIcons/map_icon_search.png',
            shadow: '/static/images/mapIcons/map_icon_search_shadow.png'
        }
    },
    markerVisible: {},
    init: function(map, latlng){
        markers.infobubble = new InfoBubble({
            map: map,
            content: '',
            position: latlng,
            shadowStyle: 1,
            padding: 0,
            backgroundColor: '#ffffff',
            opacity: 1,
            borderRadius: 7,
            minWidth: 310,
            maxWidth: 310,
            minHeight: 0,
            maxHeight: 0,
            borderWidth: 3,
            borderColor: '#fff100',
            disableAutoPan: true,
            hideCloseButton: true,
            arrowSize: 13,
            arrowPosition: 50,
            arrowStyle: 0
        });   
    },
    addMarker: function(v, type){
        var image, shadow;
        switch (type) {
            case 'cashin':
                image = new google.maps.MarkerImage(markers.views.cashin.marker,
                    new google.maps.Size(24, 35),
                    new google.maps.Point(0,0),
                    new google.maps.Point(12, 35)
                );
                shadow = new google.maps.MarkerImage(markers.views.cashin.shadow,
                    new google.maps.Size(46, 10),
                    new google.maps.Point(0,0),
                    new google.maps.Point(12, 10)
                );
                break;
            case 'office':
                image = new google.maps.MarkerImage(markers.views.office.marker,
                    new google.maps.Size(26, 42),
                    new google.maps.Point(0,0),
                    new google.maps.Point(13, 42)
                );
                shadow = new google.maps.MarkerImage(markers.views.office.shadow,
                    new google.maps.Size(34, 15),
                    new google.maps.Point(0,0),
                    new google.maps.Point(2, 15)
                );
                break;
            case 'partner':
                image = new google.maps.MarkerImage(markers.views.partner.marker,
                    new google.maps.Size(42, 42),
                    new google.maps.Point(0,0),
                    new google.maps.Point(21, 42)
                );
                shadow = new google.maps.MarkerImage(markers.views.partner.shadow,
                    new google.maps.Size(34, 15),
                    new google.maps.Point(0,0),
                    new google.maps.Point(2, 15)
                );
                break;
            default:
                image = new google.maps.MarkerImage(markers.views.office.marker,
                    new google.maps.Size(26, 42),
                    new google.maps.Point(0,0),
                    new google.maps.Point(13, 42)
                );
                shadow = new google.maps.MarkerImage(markers.views.office.shadow,
                    new google.maps.Size(34, 15),
                    new google.maps.Point(0,0),
                    new google.maps.Point(2, 15)
                );
                break;
        }

        var markerLatlng = new google.maps.LatLng(v.lat,v.lng);
        marker = new google.maps.Marker({
            position: markerLatlng,
            animation: google.maps.Animation.DROP,
            map: googlemap.map,
            shadow: shadow,
            icon: image,
            title: v.title
        });
        markers.addListeners(v, marker, markers.infobubble, markerLatlng, type);
        markers.markersArray.push(marker);
    },
    addListeners: function(v, marker, infobubble, marklatlng, type){
        var lat = marklatlng.lat();
        var lng = marklatlng.lng();
        var markerLatlngNew = new google.maps.LatLng(lat, lng);
        
        if (type == 'cashin') {
            google.maps.event.addListener(marker, 'click', function() {

                markers.closeInfoBubble();//hide the infobubble

                infobubble.setContent(  '<div><div class=\"bubble\"><a href="#" class=\"btnClose\" onclick=\"markers.closeInfoBubble();return false;\"></a>' + 
                                        '<h3>' + v.title + '</h3>' +
                                        '<p>' + v.address + '</p>' +
                                        '<p><span>' + v.content + '</span></p>' +
                                        '<div class="item"><span class="lText"><p>Время работы:</p></span>' +
                                        '<span class="rText"><p>' + v.workTime + '</p></span></div>' +
                                        '</div></div>');
                infobubble.setPosition(marker.getPosition());

                if (false === objMapObjects.mapViewFull) {
                    $('#map-box-resize').click();
                    setTimeout(function(){
                        googlemap.map.panTo(markerLatlngNew);
                        googlemap.map.panBy(150, -50);
                        markers.openInfoBubble(marker);
                    }, 600);
                } else {
                    googlemap.map.panTo(markerLatlngNew);
                    googlemap.map.panBy(150, -50);
                    markers.openInfoBubble(marker);
                }
                
            });
        } else if (type == 'office' || type == 'partner') {
            google.maps.event.addListener(marker, 'click', function() {

                markers.closeInfoBubble();//hide the infobubble

                infobubble.setContent(  '<div class=\"bubble\"><a href="#" class=\"btnClose\" onclick=\"markers.closeInfoBubble();return false;\"></a>' + 
                                        '<h3>' + v.title + '</h3>' +
                                        v.content +
                                        '</div>');
                infobubble.setPosition(marker.getPosition());

                if (false === objMapObjects.mapViewFull) {
                    $('#map-box-resize').click();
                    setTimeout(function(){
                        googlemap.map.panTo(markerLatlngNew);
                        googlemap.map.panBy(150, -50);
                        markers.openInfoBubble(marker);
                    }, 600);
                } else {
                    googlemap.map.panTo(markerLatlngNew);
                    googlemap.map.panBy(150, -50);
                    markers.openInfoBubble(marker);
                }
                
                if ($('#map_tracking').val() == 'true' && type == 'office') {
                    var requestUri = window.location.pathname + '#office_' + v.id;
                    yaCounter10379614.reachGoal(requestUri);
                    _gaq.push(['_trackPageview', requestUri]);
                }
            });
        }
        
        // mouseup marker
        google.maps.event.addListener(marker, 'mouseover', function() {
            marker.setZIndex(1000);
        }); 
    },  
    deleteMarkers: function(){
        if (markers.markersArray) {
            for (i in markers.markersArray) {markers.markersArray[i].setMap(null);}
            markers.markersArray.length = 0;
        }
    },
    getTerminals: function(cityId){
        markers.closeInfoBubble();//hide the infobubble
        $.getJSON('/ajax/geo/terminals/' + cityId, function(data) {
            if(data.success){
                $.each(data.terminals, function(i, v){
                    markers.addMarker(v, 'cashin');
                });

                // fit bounds
                if (typeof(googlemap.fitBounds) == "function") {
                    googlemap.fitBounds();
                } 
            } else {
                alert(data.message);
            }

        });
    },
    getOffices: function(cityId, type, callback){
        markers.closeInfoBubble();//hide the infobubble
        $.getJSON('/ajax/geo/offices/' + cityId, {type: type}, function(data) {
            if(data.success){
                $.each(data.offices, function(i, v){
                    markers.addMarker(v, v.type);
                });

                // fit bounds
                if (typeof(googlemap.fitBounds) == "function") {
                    googlemap.fitBounds();
                }
                if (typeof(callback) == "function") {
                    callback(data.offices);
                }
            } else {
//                alert(data.message);
                    alert('not offices');
            }

        });
    },
    closeInfoBubble: function(){     
        markers.infobubble.close();
        if(false !== (markers.markerVisible instanceof google.maps.Marker) && !markers.markerVisible.getVisible()){
            markers.markerVisible.setVisible(true);
        } 
    },      
    openInfoBubble: function(marker){
        markers.markerVisible = marker; 
        markers.markerVisible.setVisible(false);        
        markers.infobubble.open();
    }  
}

/**
 * Ready
 */
$(function() {
    if ($('#map').length) {
        googlemap.init();
        objMapObjects.init();
    }
});
