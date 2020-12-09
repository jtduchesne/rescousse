(function(Rescousse, $) {
  "use strict";
  
  function Autocomplete(input, options) {
    return new google.maps.places.Autocomplete($(input)[0], $.extend({}, this.defaults, options));
  }
  Autocomplete.prototype = {
    defaults: {
      fields: ['name','place_id'],
      types: ['establishment'],
      componentRestrictions: {country: "ca"}
    }
  };
  
  Rescousse.Autocomplete = Autocomplete;
})(window.Rescousse = window.Rescousse || {}, jQuery);
