$(document).ready(function(){
	// window.map works like var, but changes scope of following object to whole window, so you can access it from tests
	window.map = new GMaps({
		div: '#map',
		lat: 51.523126,
		lng: -0.087019,
		zoom: 13,	
		zoomControl: true,
		zoomControlOpt: {
			style: 'SMALL',
			position: 'LEFT_BOTTOM'
		},
		panControl: false,
		mapTypeControl: false,
		streetViewControl: false,
	});

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

	var zoom_options = { minZoom: 10, maxZoom: 17};

	map.setOptions(zoom_options);

	$('#search_box').on('submit', function(event) {
		event.preventDefault();
		GMaps.geocode({
			address: $('#searchTextField').val(),
			callback: function(results, status) {
				if (status == 'OK') {
					var latlng = results[0].geometry.location;
					map.setCenter(latlng.lat(), latlng.lng());
				} 
			}
		});
	})

	$.get("/jobs.json", function(jobs) {
		var markers = [];
		jobs.forEach(function(job) {
			category = job.category;
			var marker = map.addMarker({
				lat: job.latitude,
				lng: job.longitude,
				title: job.advert_title,
				category: job.category,
				icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
				infoWindow: { content: job.category }
			});
			markers.push(marker);
		});
		
		$('#category_Bar').on('change', function(){
			var checked = $(this).prop('checked');

			markers.forEach(function(marker){
				if (marker.category === $('#category_Bar').attr('value')){
					marker.setVisible(checked);
				};
			});
		});

		$('input[type=checkbox]:checked').map(function(_, el) {
			return $(el).val();
		}).get();
	});
});

