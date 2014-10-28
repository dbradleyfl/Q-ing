var map;
var geolocate;

var loadPins = function () {
  $.ajax({
    url: "/loadpins.json",
    dataType: "json",
    success: function(data){
      place_locations(data)
    }
  }).fail(function(error){
  }).always(function(){
  })
};

var place_locations = function(locations) {

  var infoWindow = new google.maps.InfoWindow({
    content: "temp"
  });

  for (var i = 0; i < locations.length; i++) {
    var latLng = new google.maps.LatLng(locations[i].latitude, locations[i].longitude);
    var marker = new google.maps.Marker({
      id: locations[i].id,
      position: latLng,
      animation: google.maps.Animation.DROP,
      map:      map,
      icon: getPinColor(locations[i].average_duration),
	  content: '<div class="infowindow">' + '<h4>'+ locations[i].name + "</h4>"+ "Category: " + ' <b>'+
      locations[i].category+"</b><br><br>" +
      '<ul class="list-group">'+'<li class="list-group-item">' +
      '<b>Average Wait Time:</b>' + '&nbsp;&nbsp;<span class="badge average_badge">' + locations[i].average_duration + " minutes"+'</span>'
       +'</li>'+'<li class="list-group-item">'+'<b>Last Wait Time:</b>'+'&nbsp;&nbsp;<span class="badge latest_badge">' +
      locations[i].latest_duration + " minutes"+'</span>'+'</li><br>'+'<button href="#" class="btn btn-danger" data-toggle="modal" data-target="#wait-timer">Q-ing Timer</button>' + '<a href="#" data-toggle="modal" data-target="#yelp">' + "&nbsp;&nbsp;" + '<img src="/assets/yelp_button.png" class="yelp_button">' + '</a>',
      outOfRangeContent: '<h4>'+ locations[i].name + "</h4>"+ "Category: " + ' <b>'+
      locations[i].category+"</b><br><br>" +
      '<ul class="list-group">'+'<li class="list-group-item">' +
      '<b>Average Wait Time:</b>' + '&nbsp;&nbsp;<span class="badge">' + locations[i].average_duration + " minutes"+'</span>'
       +'</li>'+'<li class="list-group-item">'+'<b>Last Wait Time:</b>'+'&nbsp;&nbsp;<span class="badge">' +
      locations[i].latest_duration + " minutes"+'</span>'+'</li><br>'+'<button href="#" class="btn btn-danger" data-toggle="modal" data-target="#wait-timer" disabled >Q-ing Timer</button>' + '<a href="#" data-toggle="modal" data-target="#yelp">' + "&nbsp;&nbsp;" + '<img src="/assets/yelp_button.png" class="yelp_button">' + '</a>'+"<p class='text-center text-danger'>You are too far from this location <br> to time your wait.</p>" + '</div>',
  });

    google.maps.event.addListener(marker, 'click', function() {
      console.log(this.id);
      beginTimer(this.id);
      if (findClose(geolocate, this.position) == true){
        infoWindow.setContent(this.content)
      } else {
        infoWindow.setContent(this.outOfRangeContent)
      }
      infoWindow.open(map, this);
      setYelp(this.position)
    });
  }
}
var setYelp = function (local) {
  var yelpObj = {
    yelp: {latitude: local.k, longitude: local.B}
    }
    $.ajax({
      url: '/yelp',
      type: 'get',
      data: yelpObj,
      dataType: 'json'
    }).done(function(data){
      listYelp(data.businesses)
    }).fail(function(data){
      console.log("fail from yelp")
    });
};

var listYelp = function(businesses) {
  var yelpHolder = []

  $.each(businesses, function(obj, value){
    $li = $("<li />", {
      "class" : "list-group-item"
    })

    $div1 = $("<div></div>", {
      "class" : "yelp-image-container"
    })

    $div2 = $("<div></div>", {
      "class" : "yelp-text-container"
    })
    $("<img />", { src: value.image_url, "class": "yelp_image" }).appendTo($div1)
    $("<br />").appendTo($div1)
    $("<a />", {
      "href" : value.url,
      "text" : value.review_count + " Yelp Reviews"
    }).appendTo($div1)
    $("<h4 />", { text: value.name }).appendTo($div2)
    $("<h5 />", { text: value.location.display_address }).appendTo($div2)
    $("<h6 />", { text: value.display_phone }).appendTo($div2)
    $("<img />", { src: value.rating_img_url_large }).appendTo($div2)
    $li.append($div1)
    $li.append($div2)
    yelpHolder.push($li)
  });

  $("#jester").html(yelpHolder)
}

function findClose(userPosition, markerPosition){
	console.log(userPosition.k + "  " + markerPosition.k)
	if( Math.abs(userPosition.k - markerPosition.k) < .001 && Math.abs(userPosition.B - markerPosition.B) < .001 ){
		console.log("returned true")
		return true
	} else {
		console.log("returned false")
		return false
	}
}

function getPinColor(average_duration) {


  if (average_duration === null) {
    return "/assets/Pin5.png"
  } else if (average_duration > 30) {
    return "/assets/Pin1.png"
  } else if (average_duration > 25){
    return "/assets/Pin2.png"
  } else if (average_duration > 20){
    return "/assets/Pin3.png"
  } else if (average_duration > 15){
    return "/assets/Pin4.png"
  } else    {
    return "/assets/Pin5.png"
  }

}

var buildMap = function() {
  (function initialize() {

    var markers = [];
    map = new google.maps.Map(document.getElementById('map-canvas'), {
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      disableDefaultUI: true,
      center: { lat: 37.798587, lng: -122.464398},
      zoom: 12
    });


    var input = (
      document.getElementById('pac-input'));
    map.controls[google.maps.ControlPosition.TOP].push(input);

    var searchBox = new google.maps.places.SearchBox(
      (input));

    google.maps.event.addListener(searchBox, 'places_changed', function() {
      var places = searchBox.getPlaces();

      if (places.length == 0) {
        return;
      }
      for (var i = 0, marker; marker = markers[i]; i++) {
        marker.setMap(null);
      }

      var bounds = new google.maps.LatLngBounds();
      for (var i = 0, place; place = places[i]; i++) {
        var image = {
          url: place.icon,
          size: new google.maps.Size(71, 71),
          origin: new google.maps.Point(0, 0),
          anchor: new google.maps.Point(17, 34),
          scaledSize: new google.maps.Size(25, 25)
        };
        bounds.extend(place.geometry.location);
    }
    map.fitBounds(bounds);
  });
    google.maps.event.addListener(map, 'bounds_changed', function() {
      var bounds = map.getBounds();
      searchBox.setBounds(bounds);
    });
  })();

  google.maps.event.addDomListener(window, 'load');
}

var goToUserLocation = function(){
  navigator.geolocation.getCurrentPosition(function(position) {
  var geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    map.setCenter(geolocate);
    map.setZoom(16);
  });
}

var setBlueDot = function() {
  navigator.geolocation.getCurrentPosition(function(position) {
		geolocate = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
    var marker = new google.maps.Marker({
        position: geolocate,
        map:      map,
        icon: '/assets/blue_dot.png'
    });
  });
}

var findMyLocation = function() {
  $("#find-my-location-button").on("click",function(){
    goToUserLocation();
  });
}
