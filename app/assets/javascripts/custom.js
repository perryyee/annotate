// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap

// Dynamic window height resizing based on navbar
// $(function(){
// 	$('.contained').css({'height':(($(window).height())-40)+'px'});

// 	$(window).resize(function(){
//   		$('.contained').css({'height':(($(window).height())-40+'px')});
// 	});
// });

$(function(){
	
	//Handles the transition between login/registration modal
	$('#link_register').on('click', function(){
		$('#myModal').modal('hide');
	});

	//Handles the transition between login/registration modal
	$('#link_login').on('click', function(){
		$('#myModal2').modal('hide');
	});

	//Handles AJAX session login form functions, either redirecting to new page or displaying errors
	$('.simple_form.session').submit(function(){
		var form = $(this);
		if ( $('#session_email').val() && $('#session_password').val() ){
			$.post(
				form.attr('action'),
				form.serialize(),
				function(data) {
					if (data.url){
						window.location.href = data.url;
					} else {
						$('.errors').html(data.error);
					};
				},
				"json"
			);
		}
		else
		{
			$('.errors').html("Email or Password cannot be blank.");
		}
		return false;
	});

	//Handles AJAX registration form functions, either redirecting to new page or displaying errors
	$('.simple_form.new_user').submit(function(){
		$.post(
			$(this).attr('action'),
			$(this).serialize(),
			function(data) {
				if (data.url){
					window.location.href = data.url;
				} else {
					$('.register_errors').html(data.error);
				};
			},
			"json"
		);
		return false;
	});

	//Clears AJAX login/registration errors upon closing of modal
	$('#myModal').on('hidden.bs.modal', function () {
 		$('.errors').html("");
	});
	$('#myModal2').on('hidden.bs.modal', function () {
 		$('.register_errors').html("");
	});

	//Pauses video 
	$('#loginModal').on('click', function() {
		if (player) {
			player.pauseVideo();
		}
	});
});
