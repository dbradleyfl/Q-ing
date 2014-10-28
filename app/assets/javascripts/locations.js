var setInitialPin = function(e){
    e.preventDefault();
  $.ajax({
    url: e.target.action,
    type: 'post',
    data:  $(e.target).serialize()
  }).done(function(data){
    getUserLocation(data.id);
  })
    $("#new-location").modal('hide');
    $('.navbar-toggle').click();
}

var getUserLocation = function (location_id) {

  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var userLat = position.coords.latitude
      var userLon = position.coords.longitude
      updateLocationLatLong(userLat, userLon, location_id);
    });
  } else {
    alert("Your browser or phone doesn't support geo-tagging.")
  }
}

var updateLocationLatLong = function(lat, lon, id){
  var geoLocationObj = {
    location: {latitude: lat, longitude: lon, id: id}
  }

  $.ajax({
    url: '/locations/update',
    type: 'post',
    data: geoLocationObj
  }).success(function(data){
    var geolocate = new google.maps.LatLng(lat, lon);

    map.setCenter(geolocate);
    map.setZoom(16);
    loadPins();
  }).fail(function(){
  })
}

