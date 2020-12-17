function initMap() {
  var $map = $("#map");
  
  var $form   = $("form");
  var $inputs = $("input[name!='authenticity_token']", $form);
  
  var $searchInput  = $("#searchInput", $form);
  var $searchButton = $("#searchButton", $form);
  resetForm();
  
  var $googleMapsId = $("#place_google_maps_id", $form);
  
  var $address  = $("#place_address", $form);
  var $hood     = $("#place_hood", $form);
  var $city     = $("#place_city", $form);
  var $province = $("#place_province", $form);
  var $country  = $("#place_country", $form);
  var $postcode = $("#place_postcode", $form);
  
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
      $googleMapsId.val(place.place_id);
      
      $address.val(place.address);
      $hood.val(place.hood);
      $city.val(place.city);
      $province.val(place.province);
      $country.val(place.country);
      $postcode.val(place.postcode);
      
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
