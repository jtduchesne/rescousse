function initMap() {
  var $map = $("#map");
  
  var $form   = $("form");
  var $inputs = $("input[name!='authenticity_token']", $form);
  
  var $searchInput  = $("#searchInput", $form);
  var $searchButton = $("#searchButton", $form);
  resetForm();
  
  var $uid = $("#place_uid", $form);
  
  var $latitude  = $("#place_latitude", $form);
  var $longitude = $("#place_longitude", $form);
  
  function resetForm() {
    $inputs.val("");
    $searchButton.prop('disabled', true);
  }
  
  var mapTop = $map.offset().top - $("#navbar").outerHeight();
  $searchInput.searchBox($map, function(place) {
    resetForm();
    $searchInput.val(place.name);
    
    if (place.valid) {
      $uid.val(place.place_id);
      
      if (place.geometry) {
        $latitude.val(place.geometry.location.lat);
        $longitude.val(place.geometry.location.lng);
        
        $searchButton.prop('disabled', false);
      }
    }
    
    $(".navbar-collapse").collapse('hide');
    $("html, body").animate({scrollTop: mapTop}, 1000, 'easeInOutExpo');
  });
}
