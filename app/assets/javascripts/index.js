$(document).ready(function(){

	$('#filter_form').on('submit', function(event){
		event.preventDefault();
		$.get('/jobs.json', $(this).serialize(), function(jobs){
			console.log(jobs);
			var markers = [];
			jobs.forEach(function(job) {
				category = job.category;
				var marker = map.addMarker({a
					lat: job.latitude,
					lng: job.longitude,
					title: job.advert_title,
					category: job.category,
					icon: "https://dl.dropboxusercontent.com/u/9315601/" + category + ".png",
					infoWindow: { content: job.category }
				});
				markers.push(marker);
			});
		})
	})
})