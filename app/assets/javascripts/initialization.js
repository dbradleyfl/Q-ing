$(document).ready(function(){
  loadPins();
  buildMap();
  setBlueDot();
  findMyLocation();
  $(".new-location" ).on('submit', setInitialPin.bind(this))
})