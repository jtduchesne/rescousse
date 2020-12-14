//= require ./autocomplete.js
//= require ./infomarker.js
//= require ./map.js
//= require ./place.js
//= require ./placesservice.js

(function($) {
  "use strict";
  
  var fields = ['icon','name','place_id','geometry','address_components','vicinity'];
  
  $.fn.searchBox = function(map, options, fnCallback) {
    if (typeof options === "function") {
      fnCallback = options;
      options = $.extend({}, $.fn.searchBox.defaults);
    } else {
      options = $.extend({}, $.fn.searchBox.defaults, options);
    }
    
    var gmap          = new Rescousse.Map(map, {zoom: options.zoomCity});
    var autocomplete  = new Rescousse.Autocomplete(this[0], {fields: fields});
    autocomplete.bindTo("bounds", gmap);
    
    var place         = new Rescousse.Place();
    var infomarker    = new Rescousse.InfoMarker(gmap, {labelColor: "#FFD"});
    var placesService = new Rescousse.PlacesService(gmap, {fields: fields});
    
    if (!navigator.doNotTrack && navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
        gmap.setCenter({
          lat: position.coords.latitude,
          lng: position.coords.longitude
        });
        gmap.setZoom(options.zoomCity);
        autocomplete.bindTo("bounds", gmap);
      });
    }
    
    gmap.addListener('click', function(event) {
      if (event.placeId) {
        stop();
        infomarker.hide();
        placesService.getDetails(event.placeId, setPlace);
      }
    });
    
    autocomplete.addListener('place_changed', function() {
      infomarker.hide();
      setPlace(autocomplete.getPlace());
    });
    
    function setPlace(gplace) {
      infomarker.place = place.set(gplace);
      
      if (fnCallback) fnCallback(place);
      
      if (place.valid) {
        gmap.panTo(gplace.geometry.location);
        
        (function smoothZoom(gmap, value, current) {
          if (current < value) {
            var event = gmap.addListener('zoom_changed', function() {
              google.maps.event.removeListener(event);
              smoothZoom(gmap, value, current + 1);
            });
            setTimeout(function() { gmap.setZoom(current); }, 80);
          }
        })(gmap, options.zoomPlace, gmap.getZoom());
      }
    }
    
    return this;
  };
  $.fn.searchBox.defaults = {
    zoomCity:  12,
    zoomPlace: 17,
  };
})(jQuery);
