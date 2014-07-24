$(document).ready(function(){

	$('.filter_form').on('submit', function(event){
		event.preventDefault();
		$.get('/jobs.json', $(this).serialize(), function(response){
			console.log(response);
		});
	});
})