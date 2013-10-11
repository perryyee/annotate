// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


//Upon clicking table row, redirect to corresponding video
$(document).ready(function(){
	$('tr').on('click', function(){
		var video_id = $(":last-child", this).val();
		window.location.href = "/v/"+video_id;
	});
});