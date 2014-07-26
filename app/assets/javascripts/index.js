$(document).ready(function(){
	// window.map works like var, but changes scope of following object to whole window, so you can access it from tests

	var latitude = (localStorage.getItem('lat')) ? localStorage.getItem('lat') : 51.523126
	var longitude = (localStorage.getItem('lng')) ? localStorage.getItem('lng') : -0.087019

	window.map = new GMaps({
		div: '#map',
		lat: latitude,
		lng: longitude,	
		zoom: 18,	
		zoomControl: true,
		zoomControlOpt: {
			style: 'MEDIUM',
			position: 'CENTER_LEFT'
		},
		panControl: false,
		mapTypeControl: false,
		streetViewControl: false,

		
		styles: 

		[
		{
			"featureType": "landscape",
			"elementType": "all",
			"stylers": [
			{
				"hue": "#ffffff"
			},
			{
				"saturation": -100
			},
			{
				"lightness": 100
			},
			{
                // "visibility": "simplified"
            }
            ]
        },
        ]

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
	});

	$.get("/jobs.json", function(jobs) {
		var markers = [];
		jobs.forEach(function(job) {
			category = job.category;
			var popup_template = $('#pop_up_job_advert').html();
			var job_Info = Mustache.render(popup_template,job);	
			var marker = map.addMarker({
				lat: job.latitude,
				lng: job.longitude,
				title: job.advert_title,
				category: job.category,
				icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
				infoWindow: { content: job_Info }
			});
			markers.push(marker);
		});
	});

	$('#filter_form').submit(function(event){
		event.preventDefault();
		$.get('/jobs.json', $(this).serialize(), function(jobs){
			map.removeMarkers();
			jobs.forEach(function(job) {
				category = job.category;
				var popup_template = $('#pop_up_job_advert').html();
				var job_Info = Mustache.render(popup_template,job);	
				var marker = map.addMarker({
					lat: job.latitude,
					lng: job.longitude,
					title: job.advert_title,
					category: job.category,
					icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
					infoWindow: { content: job_Info }
				});
			});


			$('.advert_column').empty();
			jobs.forEach(function(job) {
				var template = $('#individual_job_advert').html();
				var newAdvert = Mustache.render(template,job);
				$('.advert_column').append(newAdvert);

			});
		});
	});
});

