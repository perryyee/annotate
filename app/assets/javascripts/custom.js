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

// $(function(){
// 	$('.contained').css({'height':(($(window).height())-40)+'px'});

// 	$(window).resize(function(){
//   		$('.contained').css({'height':(($(window).height())-40+'px')});
// 	});
// });

$(function(){
	$('#link_register').on('click', function(){
		$('#myModal').modal('hide');
	});

	$('#link_login').on('click', function(){
		$('#myModal2').modal('hide');
	});

	// $('.simple_form.session').submit(function(){
	// 	$.post(
	// 		$(this).attr('action'),
	// 		$(this).serialize(),
	// 		function(data) {
	// 			$('#errors').html("Invalid Email/Password Combination");
	// 		},
	// 		"json"
	// 	);
	// 	return false;
	// });

	// $('.simple_form.new_user').submit(function(){
	// 	$.post(
	// 		$(this).attr('action'),
	// 		$(this).serialize(),
	// 		function(data) {
	// 			$('#errors').html('<br/><p>Thank you for your patience. Synchronization to Facebook has completed, enjoy!</p><a href="/heatmap"><button type="button" class="btn btn-primary">Explore!</button></a> <button type="button" data-dismiss="modal" class="btn btn-danger">Close</button>');
	// 		},
	// 		"json"
	// 	);
	// 	//return false;
	// });
});
