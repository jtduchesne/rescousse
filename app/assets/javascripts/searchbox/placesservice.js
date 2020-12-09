(function(Rescousse, $) {
  "use strict";
  
  function PlacesService(gmap, options) {
    $.extend(this.options, this.defaults, options);
    
    this.service = new google.maps.places.PlacesService(gmap);
  }
  PlacesService.prototype = {
    getDetails: function(placeId, fnCallback) {
      this.service.getDetails({
        placeId: placeId,
        fields: this.options.fields
      }, function(place, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          fnCallback(place);
        }
      });
    },
    
    options: {},
    defaults: {
      fields: ['name','place_id']
    }
  };
  
  Rescousse.PlacesService = PlacesService;
})(window.Rescousse = window.Rescousse || {}, jQuery);
