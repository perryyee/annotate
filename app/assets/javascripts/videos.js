// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

//  This code loads the IFrame Player API code asynchronously.

var notes = [];
var tag = document.createElement('script');
var count = 1;

function note_data(time, title, content) 
{
	this.time = time;
	this.title = title;
	this.content = content;
}

tag.src = "http://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

// This function creates an <iframe> (and YouTube player)
//    after the API code downloads.
var player;
function onYouTubeIframeAPIReady() {
	var id = document.getElementById('video_id').value;
	player = new YT.Player('player', {
	  height: '390',
	  width: '640',
	  videoId: id,
	  playerVars: { 'autoplay': 1},
	  events: {
	    'onReady': onPlayerReady,
	    'onStateChange': onPlayerStateChange
	  }
    });
}

// The API will call this function when the video player is ready.
function onPlayerReady(event) {
event.target.playVideo();
}

// The API calls this function when the player's state changes.
//    The function indicates that when playing a video (state=1),
//    the player should play for six seconds and then stop.
var done = false;
function onPlayerStateChange(event) {
	if (event.data == YT.PlayerState.PLAYING && !done) {
	  //done = true;

	  var timeout = setTimeout(function(){
	  	var first_time = -1;
	  	var second_time = -1;
	  	var third_time = -1;
	  	var fourth_time = -1;

		var interval = setInterval(function(){
			time = Math.ceil(player.getCurrentTime());
		  	if (time != first_time && time!= second_time && time!=third_time) {
			  	console.log(time);

			  	for (var i=0; i<notes.length; i++) {
			    	if(Math.ceil(player.getCurrentTime()) === notes[i]['time']) {
			    		content = unescape(notes[i]['content']);
			    		content = content.replace(/\r?\n/g, '<br />');

				        document.getElementById('note-title').innerHTML = "<h3>"+notes[i]['title']+"</h3>";
				        document.getElementById('note-content').innerHTML = "<p>"+content+"</p>";
			    	}
			    }
			    first_time = time;
			    second_time = first_time;
			    third_time = second_time;
			    fourth_time = third_time;
			}
			else 
			{
				clearInterval(interval);
			}

		  },1000);
		}, 0);
	}

}
function stopVideo() {
	player.stopVideo();
}



$(document).ready(function(){
	$('.results').on('click', function(){
		url = $(':first-child', this).val()
		window.location.href = "/videos/"+url;
	});


	$('#note_title').on('focus', function(){
		time = player.getCurrentTime();
		$('#note_time').val(time);
	});

	$('#new_note').submit(function(){
		if ($('#note_title').val()) 
		{
			$.post(
				$(this).attr('action'),
				$(this).serialize(),
				function(data) {
					time = $('#note_time').val();
					minutes = Math.floor(time/60);
					seconds = Math.floor(time-minutes*60);
					if (seconds == 0 || seconds ==-1)
					{
						seconds = "00";
					}
					else if (seconds < 10)
					{
						seconds = "0"+seconds;
					}
					time_format = minutes+":"+seconds;
					title = $('#note_title').val();
					content = escape($("#note_content").val());
					note = new note_data(Math.floor(time), title, content);
					notes.push(note);

					$(".note_errors").html("Successfully Created Note");
					$(".table tbody").append("<tr><input id='skip_to' type='hidden' value="+Math.floor(time)+"><input id='new_title' type='hidden' value='"+title+"'><input id='new_content' type='hidden' value='"+content+"'><td>"+time_format+"</td><td>"+title+"</td></tr>");
					
					$('tr').on('click', function(){
						time = $(':first-child', this).val();
						title = $(':nth-child(2)', this).val();
						content = unescape($(':nth-child(3)', this).val());
						content = content.replace(/\r?\n/g, '<br />')

						player.seekTo(time);
						$('#note-title').html("<h3>"+title+"</h3>");
						$('#note-content').html("<p>"+content+"</p>");
					});

					$('#note_title').val("");
					$('#note_content').val("");
				},
				"json"
			);
		} 
		else 
		{
			$(".note_errors").html("<p>Title cannot be blank.</p>");
		}
		return false;
	});

	$('#nextToken').submit(function(){
		$('#nextSearch').val($('#searchQuery').val());
		// $.post(
		// 	$(this).attr('action'),
		// 	$(this).serialize(),
		// 	function(data) {
				
		// 	},
		// 	"json"
		// );
		// return false;
	});

	$('#prevToken').submit(function(){
		$('#prevSearch').val($('#searchQuery').val());
		// $.get(
		// 	$(this).attr('action'),
		// 	$(this).serialize(),
		// 	function(data) {

		// 	},
		// 	"json"
		// );
		// return false;
	});
});