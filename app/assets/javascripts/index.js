$(document).ready(function(){
	// window.map works like var, but changes scope of following object to whole window, so you can access it from tests

	// var latitude = (localStorage.getItem('lat')) ? localStorage.getItem('lat') : 51.523126;
	// var longitude = (localStorage.getItem('lng')) ? localStorage.getItem('lng') : -0.087019;
	// var currentMapCenter = (latitude,longitude);
	// console.log(currentMapCenter);

	var latitude = 51.523126;
	var longitude = -0.087019;
	

	window.map = new GMaps({
		div: '#map',
		lat: latitude,
		lng: longitude,	
		zoom: 9,	
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

	var zoom_options = { minZoom: 9, maxZoom: 17};
	map.setOptions(zoom_options);

	// creating a marketcluster object
	// var mcOptions = {gridSize: 50, maxZoom: 15};
	// var mc = new MarkerClusterer(map);
	// var mc = new MarkerClusterer(map, [], mcOptions);
	// var mc = new MarkerClusterer(map, markers, mcOptions);


	var renderMarker = function(job){
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
	};

	var calcDistanceKms = function(map,job) {
		var mapCenter = map.getCenter();
		var markerLocation = new google.maps.LatLng(job.latitude,job.longitude);
	  var markerDistance = google.maps.geometry.spherical.computeDistanceBetween(mapCenter, markerLocation);
	  // console.log(markerDistance/1000);
	  return markerDistance/1000;
	};

	var submitFilterForm = function(jobs){
		map.removeMarkers();
		var advertsRefined = [];
			jobs.forEach(function(job) {
						// console.log('hello');
						// console.log(job.max_distance);
				if (calcDistanceKms(map,job) <= job.max_distance) {			
						// console.log('hello');
						renderMarker(job);
						advertsRefined.push(job);
					};
			});
		updateAdvertColumn(advertsRefined);
	};

	$.get("/jobs.json", function(jobs) {
		var markers = [];
		jobs.forEach(function(job) {
			renderMarker(job);
			// markers.push(job);
		});
		// var mc = new MarkerClusterer(map, markers, mcOptions);
	});

	$('#filter_form').submit(function(event){
		event.preventDefault();
			$.get('/jobs.json', $(this).serialize(), function(jobs){
				submitFilterForm(jobs);
			});
	});


	$('#search_box').on('submit', function(event) {
			event.preventDefault();

			GMaps.geocode({
				address: $('#searchTextField').val(),
				callback: function(results, status) {
					if (status == 'OK') {
						var latlng = results[0].geometry.location;
						map.setCenter(latlng.lat(), latlng.lng());
						$.get('/jobs.json',$('#filter_form').serialize(), function(jobs) {
							submitFilterForm(jobs);
					});
				}
			}
		});
	});


	var updateAdvertColumn = function(jobs){
		$('.advert_column').empty();
		jobs.forEach(function(job) {
			var template = $('#individual_job_advert').html();
			var newAdvert = Mustache.render(template,job);
			$('.advert_column').append(newAdvert);
		});
	};





});

