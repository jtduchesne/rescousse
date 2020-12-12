function initMap() {
  var $map = $("#map");
  
  var $form   = $("form");
  var $inputs = $("input[name!='authenticity_token']", $form);
  resetForm();
  
  var $searchInput  = $("#searchInput", $form);
  var $searchButton = $("#searchButton", $form);
  
  var $address  = $("#place_address", $form);
  var $hood     = $("#place_hood", $form);
  var $city     = $("#place_city", $form);
  var $province = $("#place_province", $form);
  var $postcode = $("#place_postcode", $form);
  
  var $latitude  = $("#place_latitude", $form);
  var $longitude = $("#place_longitude", $form);
  
  function resetForm() {
    $inputs.val("");
  }
  
  var mapTop = $map.offset().top - $("#navbar").outerHeight();
  $searchInput.searchBox($map, function(place) {
    resetForm();
    $searchInput.val(place.name);
    
    $address.val(
      place.address_components.slice(0,2).map(function(v) {
        return v.long_name;
      }).join(", ")
    );
    $hood.val(place.address_components[2].long_name);
    $city.val(place.address_components[3].long_name);
    $province.val(place.address_components[5].short_name);
    $postcode.val(place.address_components[7].long_name);
    
    if (place.geometry) {
      $latitude.val(place.geometry.location.lat);
      $longitude.val(place.geometry.location.lng);
      
      $searchButton.prop('disabled', false);
    } else {
      $searchButton.prop('disabled', true);
    }
    
    $(".navbar-collapse").collapse('hide');
    $("html, body").animate({scrollTop: mapTop}, 1000, 'easeInOutExpo');
  });
}
