$(document).ready(function(){
	console.log("hello")
	console.log("wooooorkmap")
});





$(document).ready(function(){
	// window.map works like var, but changes scope of following object to whole window, so you can access it from tests

	var defaultBounds = new google.maps.LatLngBounds(
		new google.maps.LatLng(51.2901, -0.5651),
		new google.maps.LatLng(51.6167, 0.2463)
		);

	var input = document.getElementById('searchTextField');

	var search_options = {
		bounds: defaultBounds,
		types: ['establishment']
	};

	autocomplete = new google.maps.places.Autocomplete(input, search_options);
	
	console.log("hello")

	$('#landing_page_search_box').on('submit', function(event) {
		event.preventDefault();
		GMaps.geocode({
			address: $('#landing_page_searchTextField').val(),
			callback: function(results, status) {
				if (status == 'OK') {
					var latlng = results[0].geometry.location;
					window.location.replace("http://wwww.google.co.uk");
					map.setCenter(latlng.lat(), latlng.lng());
				} 
			}
		});
	});

});
