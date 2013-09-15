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
        if (letters === undefined) {
            callback([]);

            return false;
        }

        this.api(this.resources.regions, {'letters': letters}, function(data) {
            callback(data);
        });

        return true;
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

        this.api(this.resources.areas, dataRequest, function(data) {
            callback(data);
        });

        return true;
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

        this.api(this.resources.streets, dataRequest, function(data) {
            callback(data);
        });

        return true;
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
