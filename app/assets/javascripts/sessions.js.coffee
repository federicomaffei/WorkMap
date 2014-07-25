# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("form#sign_in_user").bind "ajax:success", (e, data, status, xhr) ->
	if data.success
		$('#sign_in').modal('hide')
		$('#sign_in_button').hide()
		$('#submit_comment').slideToggle(1000, "easeOutBack" )
	else
		alert('failure!')