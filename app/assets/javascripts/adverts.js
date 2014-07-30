$(document).ready(function(){

var map = new GMaps({
  div: '#map-advert',
  lat: 0,
  lng: 0
});

GMaps.geocode({
  address: $('.advert-address').text(),
  callback: function(results, status) {
    if (status == 'OK') {
      var latlng = results[0].geometry.location;
      map.setCenter(latlng.lat(), latlng.lng());
      map.addMarker({
        lat: latlng.lat(),
        lng: latlng.lng()
      });
    }
  }
});

console.log($('.advert-address').text());

})