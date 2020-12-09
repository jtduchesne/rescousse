(function(Rescousse, $) {
  "use strict";
  
  function Map(map, options) {
    var $map = $(map);
    
    options = $.extend({}, options);
    if ($map.data("lat"))
      options.center = $.extend({}, {lat: parseFloat($map.data("lat"))}, options.center);
    if ($map.data("lng"))
      options.center = $.extend({}, {lng: parseFloat($map.data("lng"))}, options.center);
    
    if (!options.center || !options.center.lat || !options.center.lng)
      delete options.zoom;
    
    return new google.maps.Map($map[0], $.extend({}, this.defaults, options));
  }
  Map.prototype = {
    defaults: {
      center: {
        lat:  47.0707212,
        lng: -70.5677533
      },
      zoom: 8,
      fullscreenControl: false,
      mapTypeControl:    false,
      streetViewControl: false,
      keyboardShortcuts: false,
      minZoom: 8
    }
  };
  
  Rescousse.Map = Map;
})(window.Rescousse = window.Rescousse || {}, jQuery);
