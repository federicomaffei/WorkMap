$(document).ready(function(){

	$(document).on('click', '.info', function(){
		$(this).parent().addClass('clicked');
	});

	$(document).on('click', '.more_info', function(){
		$(this).parent().removeClass('clicked');
	})
})