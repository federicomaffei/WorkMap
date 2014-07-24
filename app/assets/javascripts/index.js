$(document).ready(function(){

	window.map = new GMaps({
		div: '#map',
		lat: 51.523126,
		lng: -0.087019,
		zoom: 14,	
		zoomControl: true,
		zoomControlOpt: {
			style: 'MEDIUM',
			position: 'LEFT_BOTTOM'
		},
		panControl: false,
		mapTypeControl: false,
		streetViewControl: false,

		styles: [
		{
			stylers: [
			{ hue: "#00ff6f" },
			{ saturation: -50 }
			]
		}, {
			featureType: "road",
			elementType: "geometry",
			stylers: [
			{ lightness: 100 },
			{ visibility: "simplified" }
			]
		}, {
			featureType: "transit",
			elementType: "geometry",
			stylers: [
			{ hue: "#ff6600" },
			{ saturation: +80 }
			]
		}, {
			featureType: "transit",
			elementType: "labels",
			stylers: [
			{ hue: "#ff0066" },
			{ saturation: +80 }
			]
		}, {
			featureType: "poi",
			elementType: "labels",
			stylers: [
			{ visibility: "off" }
			]
		}, {
			featureType: "poi.park",
			elementType: "labels",
			stylers: [
			{ visibility: "on" }
			]
		}, {
			featureType: "water",
			elementType: "geometry",
			stylers: [
			{ hue: "#c4f4f4" }
			]
		}, {
			featureType: "road",
			elementType: "labels",
			stylers: [
			{ visibility: "off" }
			]
		}
		]
	});

	$('#filter_form').on('submit', function(event){
		event.preventDefault();
		$.get('/jobs.json', $(this).serialize(), function(jobs){
			var markers = [];
			jobs.forEach(function(job) {
				category = job.category;
				var marker = map.addMarker({
					lat: job.latitude,
					lng: job.longitude,
					title: job.advert_title,
					icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
					infoWindow: { content: job.category }
				});
				markers.push(marker);
			});
		})
	})
})