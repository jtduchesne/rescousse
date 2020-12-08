function initMap() {
  var map   = document.getElementById('map');
  var input = document.getElementById('searchInput');
  input.value = "";
  
  var province = { lat: 47.0707212, lng: -70.5677533 };
  var position = {
    lat: parseFloat(map.dataset.lat),
    lng: parseFloat(map.dataset.lng)
  };
  var zoom = ((position.lat === province.lat) && (position.lng === province.lng)) ? 8 : 12;
  
  var gmap = new google.maps.Map(map, {
    center: position,
    zoom: zoom,
    fullscreenControl: false,
    mapTypeControl:    false,
    streetViewControl: false,
    keyboardShortcuts: false,
    minZoom: 8
  });
  
  var fields = ['name','place_id','icon','geometry','address_components'];
  
  var autocomplete = new google.maps.places.Autocomplete(input, {
    fields: fields,
    types: ['establishment'],
    componentRestrictions: {country: "ca"}
  });
  autocomplete.bindTo("bounds", gmap);
  
  if (!navigator.doNotTrack && navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      gmap.setCenter({
        lat: position.coords.latitude,
        lng: position.coords.longitude
      });
      gmap.setZoom(12);
      autocomplete.bindTo("bounds", gmap);
    });
  }
  
  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({ map: gmap });
  
  gmap.addListener('click', function(event) {
    if (event.placeId) {
      stop();
      infowindow.close();
      marker.setVisible(false);
      
      (new google.maps.places.PlacesService(gmap)).getDetails({
        placeId: event.placeId,
        fields: fields
      }, function(place, status) {
        if (status === google.maps.places.PlacesServiceStatus.OK) {
          setPlace(place);
        }
      });
    }
  });
  
  var navbarHeight = $("#navbar").outerHeight();
  autocomplete.addListener('place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    
    var target = $('#map')
    $('.navbar-collapse').collapse('hide');
    $('html, body').animate({
      scrollTop: (target.offset().top - navbarHeight)
    }, 1000, "easeInOutExpo");
    
    setPlace(autocomplete.getPlace());
  });
  
  function filterLabel(name) {
    return name.replace(
      /\b(bar|pub|taverne|cabaret|(micro-?)?(brasserie|brewery)|caf(e|é)|rest(o|aurant)|the|le|la|l|of|du|de|d|my|mon|ma|\W+)\b/gi,""
    ).trim().toUpperCase();
  }
  function setPlace(place) {
    input.value = place.name;
    if (place.geometry) {
      var label = filterLabel(place.name);
      if (label) {
        marker.setLabel({
          text: label[0],
          color: "#FFF",
          fontWeight: "700"
        });
      }
      marker.setPosition(place.geometry.location);
      marker.setVisible(true);
      
      gmap.panTo(place.geometry.location);
      smoothZoomTo(17);
 
      var address = "";
      if (place.address_components) {
        address = [
          (place.address_components[0] && place.address_components[0].short_name),
          (place.address_components[1] && place.address_components[1].short_name),
          (place.address_components[2] && place.address_components[2].short_name)
        ].filter(function(e) { return e; }).join(", ");
      }
 
      infowindow.setContent("<div>"+
                              "<h6 class='align-middle'>"+
                                "<img src='"+ place.icon +"' width='16' height='16' />&nbsp;"+ place.name +
                              "</h6>"+
                              address +
                            "</div>");
      infowindow.open(gmap, marker);
    }
  }
  
  function smoothZoomTo(value) {
    (function smoothZoom(map, value, current) {
      if (current < value) {
        var event = map.addListener('zoom_changed', function() {
          google.maps.event.removeListener(event);
          smoothZoom(map, value, current + 1);
        });
        setTimeout(function() { map.setZoom(current) }, 80);
      }
    })(gmap, value, gmap.getZoom())
  }
}
