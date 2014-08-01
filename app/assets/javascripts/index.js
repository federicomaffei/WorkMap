$(document).ready(function(){
	
	var latitude = (localStorage.getItem('lat')) ? localStorage.getItem('lat') : 51.497830;
	var longitude = (localStorage.getItem('lng')) ? localStorage.getItem('lng') : -0.132523;


	// window.map works like var, but changes scope of following object to whole window, so you can access it from tests
	var mapOptions = {
		center: new google.maps.LatLng(latitude, longitude),
		zoom: 14,
	  zoomControl: true,
		zoomControlOpt: {
			style: 'MEDIUM',
			position: 'LEFT_BOTTOM'
		},
		panControl: false,
		mapTypeControl: false,
		streetViewControl: false,
		styles: 
		[
		{
        "featureType": "water",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#a2daf2"
            }
        ]
    },
    {
        "featureType": "landscape.man_made",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#f7f1df"
            }
        ]
    },
    {
        "featureType": "landscape.natural",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#d0e3b4"
            }
        ]
    },
    {
        "featureType": "landscape.natural.terrain",
        "elementType": "geometry",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.park",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#C9D787"
            }
        ]
    },
    {
        "featureType": "poi",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "poi.medical",
        "elementType": "geometry",
        "stylers": [
            {
                "color": "#fbd3da"
            }
        ]
    },
    {
        "featureType": "poi.business",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road",
        "elementType": "labels",
        "stylers": [
            {
                "visibility": "off"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffe15f"
            }
        ]
    },
    {
        "featureType": "road.highway",
        "elementType": "geometry.stroke",
        "stylers": [
            {
                "color": "#efd151"
            }
        ]
    },
    {
        "featureType": "road.arterial",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#ffffff"
            }
        ]
    },
    {
        "featureType": "road.local",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "black"
            }
        ]
    },
    {
        "featureType": "transit.station.airport",
        "elementType": "geometry.fill",
        "stylers": [
            {
                "color": "#cfb2db"
            }
        ]
    }
    ]

	};

	// initializing map object
	var map = new google.maps.Map(document.getElementById("map"), mapOptions);

	// additional map options
	var zoom_options = { minZoom: 9, maxZoom: 17};
	map.setOptions(zoom_options);

	// define empty markers array, marketclusterer var and options
	var markers = [];
	var markerCluster;
	var mcOptions = {gridSize: 100, maxZoom: 16};

	// setting up google autocomplete for address search bar
	var defaultBounds = new google.maps.LatLngBounds(
		new google.maps.LatLng(51.2901, -0.5651),
		new google.maps.LatLng(51.6167, 0.2463)
		);

	var inputs = document.querySelectorAll('.searchTextField');

	var search_options = {
		bounds: defaultBounds,
		types: ['establishment']
	};

	autocomplete = new google.maps.places.Autocomplete(inputs[0], search_options);
	new google.maps.places.Autocomplete(inputs[1], search_options);

	// PAGE LOAD and LISTENERS for FILTERING and SEARCH

	// on page reload render job markers and populate RHS job adverts pane
	$.get("/jobs.json", function(jobs) {
		renderMarkers(jobs);
		updateAdvertColumn(jobs);
		markerCluster = new MarkerClusterer(map, markers, mcOptions);
	});

	// event listener for filter form submission, calls getFormData first to correctly format json
	$('#filter_form').submit(function(event){
		event.preventDefault();
		var form = getFormData();

		$.get('/jobs.json', form, function(jobs){
			submitFilterForm(jobs);
		});

	});	

	// event listener for google search, successful geocode results in complete re-render or markers and RHS job adverts pane whilst maintaining current form filters 
	$('.search_box').on('submit', function(event) {
			event.preventDefault();
			var form = getFormData();
			var geocoder = new google.maps.Geocoder();

			geocoder.geocode( {'address': $(this).find('.searchTextField').val()}, function(results, status) {
	      if (status == google.maps.GeocoderStatus.OK) {
		        map.setCenter(results[0].geometry.location);
						
						$.get('/jobs.json',form, function(jobs) {
							submitFilterForm(jobs);
						});
	      } else {
	        alert("You search address was not recognised: " + status);
	      }
	    });
  
  });


	// REFACTORED HELPER METHODS

	// renders markers and infowindows on map, adds listener to each marker
	var renderMarkers = function(jobs){
		jobs.forEach(function(job) {		
				var category = job.category;
				var popup_template = $('#pop_up_job_advert').html();
				var job_Info = Mustache.render(popup_template,job);	
				var latLng = new google.maps.LatLng(job.latitude,job.longitude);
				
				var marker = new google.maps.Marker({
					position: latLng,
					title: job.advert_title,
					category: job.category,
					icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
				});

				marker.infowindow = new google.maps.InfoWindow( {
					content: job_Info
				});

				// Add event listener apply now link in infowidows
			  // google.maps.event.addListener(marker.infowindow, 'domready', function() {
	  	 //    document.id("apply-link").addEvent("click", function(e) {
			  //       e.stop();
			  //       console.log("hi!");
			  //   });
				 //    // var email = $(this).data('email');
					// 	// $('#submission_email').val(email);
			  // });


			  google.maps.event.addListener(marker, 'click', function() {
			    marker.infowindow.open(map,marker);
			  });

				markers.push(marker);
		});
	};

	// update RHS job adverts pane
	function updateAdvertColumn(jobs) {
		$('.advert_column').empty();
		var adverts = [];

    $.each(jobs, function (i, job) {
				job['linkid'] = i;
				job['distance'] = precise_round(calcDistanceKms(map,job),1); 
				adverts.push(job);
    });

    var adverts = sortByDistance(adverts);

    $.each(adverts, function (i, job) {
      var template = $('#individual_job_advert').html();
			var newAdvert = Mustache.render(template,job);
			
			$('.advert_column').append(newAdvert);
  
			$('#openlink'+i).on('click', function() {
			    google.maps.event.trigger(markers[i], 'click');
		  });
			
			$('#closelink'+i).on('click', function() {
						var infowindow = markers[i]['infowindow'];
						markers[i].infowindow.close();
		  });

  		$('.apply-link').on('click', function(){
  			// console.log('hello');
				var email = $(this).data('email');
			$('#submission_email').val(email);
			})


    });

	};

	// rounds precisley to 2dps
	function precise_round(num,decimals) {
	    return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);
	}

	// submits filter form
	function submitFilterForm(jobs) {
		markers = [];
		var max_distance = jobs[0].max_distance;

		var filteredJobs = filterByMaxDistance(jobs,max_distance);
		renderMarkers(filteredJobs);
		updateAdvertColumn(filteredJobs);
		markerCluster.clearMarkers()
		markerCluster.addMarkers(markers);
	};


	// calcs distance between a job marker can map center (in Kms)
	function calcDistanceKms(map,job) {
		var mapCenter = map.getCenter();
		var markerLocation = new google.maps.LatLng(job.latitude,job.longitude);
	  var markerDistance = google.maps.geometry.spherical.computeDistanceBetween(mapCenter, markerLocation);
	  return markerDistance/1000;
	};

	// clears all markers on map
	function clearMarkers() {
		for (var i = 0; i < markers.length; i++) {
	    markers[i].setMap(null);
	  }
	  markers = [];
	};


	// filters out all job objects from jobs array that lie outside distance scope
	function filterByMaxDistance(jobs,max_distance){
		var filtereredJobs = [];
			jobs.forEach(function(job) {
				if (calcDistanceKms(map,job) <= job.max_distance) {	
					filtereredJobs.push(job);
				};
			});
		return filtereredJobs;
	};

	// sorts array of jobs by distance 
	function sortByDistance(jobs){
    	jobs.sort(function(a,b){
			  if(a.distance > b.distance){ return 1}
		    if(a.distance < b.distance){ return -1}
	      return 0;
			});
			return jobs;
	};

  
	// gathers current filter form variables, manually creates key value pairs before adding distance and wage
	function getFormData(){
		var distance = $('#distance_slider').slider('getValue');
		var wage = $('#wage_slider').slider('getValue');		
		var formArray = $('#filter_form').serializeArray();
		var form = {};

    $.each(formArray, function (i, input) {
        form[input.name] = input.value;
    });
		
		form['distance'] = distance;
		form['wage'] = wage;

		return form;
	};

	// listeners for filter slide bars
	$('#distance_slider').slider({
		formater: function(value) {
			return 'Current value: ' + value;
		}
	});
	$('#wage_slider').slider({
		formater: function(value) {
			return 'Current value: ' + value;
		}
	});

	// making google maps dynamically responsive to window resizing
	google.maps.event.addDomListener(window, "resize", function() {
	 var center = map.getCenter();
	 google.maps.event.trigger(map, "resize");
	 map.setCenter(center); 
	});


});





