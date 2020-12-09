function initMap() {
  var $map   = $("#map");
  var $input = $("#searchInput");
  $input.val("");
  
  var mapTop = $map.offset().top - $("#navbar").outerHeight();
  
  $input.searchBox($map, function(place) {
    $input.val(place.name);
    
    $(".navbar-collapse").collapse('hide');
    $("html, body").animate({scrollTop: mapTop}, 1000, 'easeInOutExpo');
  });
}
