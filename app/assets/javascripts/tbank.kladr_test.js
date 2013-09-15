window.TBank = window.TBank || {};

TBank.Kladr = {
    resources: {
        regions:    '/ajax/fias/regions/',
        areas:      '/ajax/fias/areas/',
        places:     '/ajax/fias/places/',
        streets:    '/ajax/fias/streets/',
        houses:     '/ajax/fias/houses/',
        indexes:    '/ajax/fias/indexes/',
        info:       '/ajax/fias/object/{id}/'
    },
    cascadeAjax: false,
    regionsByLetters: function(letters, callback){
        callback({"results": [{"level": 1, "text": "\u041c\u043e\u0441\u043a\u0432\u0430 (\u0433)", "number_of_places": 49, "number_of_streets": 3513, "centstatus": 0, "id": "0c5b2444-70a0-4932-980c-b4dc0d3f02b5"}, {"level": 1, "text": "\u041c\u043e\u0441\u043a\u043e\u0432\u0441\u043a\u0430\u044f (\u043e\u0431\u043b)", "number_of_places": 75, "number_of_streets": 0, "centstatus": 0, "id": "29251dcf-00a1-4e34-98d4-5c47484a36d4"}], "success": true})
    },
    objectById: function(id, callback){
        if (id === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.info.replace('{id}', id), {}, function(data) {
            callback(data);
        });

        return true;
    },
    regionById: function(id, callback){
        if (id === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.region.replace('{id}', id), {}, function(data) {
            callback(data);
        });

        return true;
    },
    areasByLettersAndParentId: function(letters, parentId, callback){
        callback({"results": [{"level": 1, "text": "\u041c\u043e\u0441\u043a\u0432\u0430 (\u0433)", "number_of_places": 49, "number_of_streets": 3513, "centstatus": 0, "id": "0c5b2444-70a0-4932-980c-b4dc0d3f02b5"}, {"level": 3, "text": "\u041c\u043e\u0441\u043a\u043e\u0432\u0441\u043a\u0438\u0439 (\u043f)", "number_of_places": 12, "number_of_streets": 0, "centstatus": 0, "id": "762758bb-18b9-440f-bc61-8e1e77ff3fd8"}], "success": true})
    },
    areaById: function(id, callback){
        if (id === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.area.replace('{id}', id), {}, function(data) {
            callback(data);
        });

        return true;
    },
    placesByLettersAndParentId: function(letters, parentId, callback){
        if (letters === undefined) {
            callback([]);

            return false;
        }

        var dataRequest = {
            letters: letters
        };

        if (parentId !== undefined) {
            dataRequest['parent'] = parentId;
        }

        this.api(this.resources.places, dataRequest, function(data) {
            callback(data);
        });

        return true;
    },
    placeById: function(id, callback){
        if (id === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.place.replace('{id}', id), {}, function(data) {
            callback(data);
        });

        return true;
    },
    streetsByLettersAndParentIdAndIndex: function(letters, parentId, index, callback){
        if (letters === undefined) {
            callback([]);

            return false;
        }

        var dataRequest = {
            'letters': letters
        };

        if (parentId !== undefined) {
            dataRequest['parent'] = parentId;
        }

        if (index !== undefined) {
            dataRequest['index'] = index;
        }

        this.api(this.resources.streets, dataRequest, function(data) {
            callback(data);
        });

        return true;
    },
    streetsByLettersAndParentId: function(letters, parentId, callback){
        callback({"results": [{"level": 7, "text": "\u041b\u0435\u043d\u0438\u0432\u043a\u0430 (\u0443\u043b)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "1b9f709b-9ab7-460d-b5f5-803f71f792c3"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u0433\u0440\u0430\u0434\u0441\u043a\u0438\u0439 (\u043f\u0440-\u043a\u0442)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "9c3e9392-0324-4d21-9cf5-70076f1b5e15"}, {"level": 7, "text": "\u041b\u0435\u043d\u0441\u043a\u0430\u044f (\u0443\u043b)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "bed7daf2-13e1-4e62-8f99-360cdd72fb2f"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u0441\u043a\u0438\u0435 \u0413\u043e\u0440\u044b (\u0443\u043b)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "12bf2472-62ee-4db6-b998-565141e7a9d1"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u0441\u043a\u0438\u0439 (\u043f\u0440-\u043a\u0442)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "5f2a1243-a57b-418e-baee-ff76f4993b45"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u0441\u043a\u0430\u044f \u0421\u043b\u043e\u0431\u043e\u0434\u0430 (\u0443\u043b)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "62d9bfcb-278d-48e6-ba60-c23e9776d305"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u043e\u0433\u043e\u0440\u0441\u043a\u0430\u044f (\u0443\u043b)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "91ab1cb1-d0a4-489c-9182-9dfbabcd9e2b"}, {"level": 7, "text": "\u041b\u0435\u043d\u0438\u043d\u0433\u0440\u0430\u0434\u0441\u043a\u043e\u0435 (\u0448)", "number_of_places": 0, "number_of_streets": 0, "centstatus": 0, "id": "c5fec714-04f5-4cb3-89d8-d7cec97116e6"}], "success": true})
    },

    streetById: function(id, callback){
        if (id === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.street.replace('{id}', id), {}, function(data) {
            callback(data);
        });

        return true;
    },
    housesByParentId: function(parentId, callback){
        if (parentId === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.houses, {'parent': parentId}, function(data) {
            callback(data);
        });

        return true;
    },
    housesByLettersAndParentId: function(letters, parentId, callback){
        if (parentId === undefined) {
            callback([]);

            return false;
        }

        var dataRequest = {
            'letters': letters
        };

        if (parentId !== undefined) {
            dataRequest['parent'] = parentId;
        }

        this.api(this.resources.houses, dataRequest, function(data) {
            callback(data);
        });

        return true;
    },
    housesByIndex: function(index, callback){
        if (index === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.houses, {'by': 'index', 'value': index}, function(data) {
            callback(data);
        });

        return true;
    },
    indexesByLetters: function(letters, callback){
        if (letters === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.indexes, {'letters': letters}, function(data) {
            callback(data);
        });

        return true;
    },
    infoByIndex: function(index, callback){
        if (index === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.info.replace('{id}', index), {}, function(data) {
            callback(data);
        });

        return true;
    },
    preloaderShow: null,
    preloaderHide: null,
    api: function(resource, dataRequest, callback) {
        var _this   = this;

        if (dataRequest === undefined) {
            dataRequest = {};
        }

        // preloader show
        if (typeof this.preloaderShow === 'function') {
            this.preloaderShow();
        }

        var request = $.ajax({
            url: resource,
            type: "GET",
            data: dataRequest,
            dataType: 'json'
        });

        request.done(function(data) {
            // preloader hide
            if (typeof _this.preloaderHide === 'function' && false === _this.cascadeAjax) {
                _this.preloaderHide();
            }

            if(data.success){
                callback(data);
            } else {
                callback({});
            }
        });

        request.fail(function() {
            // preloader hide
            if (typeof _this.preloaderHide === 'function' && false === _this.cascadeAjax) {
                _this.preloaderHide();
            }

            callback([]);
        });

        return request;
    }
}
