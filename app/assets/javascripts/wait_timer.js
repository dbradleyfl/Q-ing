var beginTimer = function(id) {

	var h1 = document.getElementsByTagName('h1')[0],
	start = document.getElementById('start'),
	stop = document.getElementById('stop'),
	clear = document.getElementById('clear'),
	cancel = document.getElementById('cancel'),
	submit = document.getElementById('submit'),
	seconds = 0,
	minutes = 0,
	hours = 0,
	t;

	var add = function() {
		seconds++;
		if (seconds >= 60) {
			seconds = 0;
			minutes++;
			if (minutes >= 60) {
				minutes = 0;
				hours++;
			}
		}

		h1.textContent = (hours ? (hours > 9 ? hours : "0" + hours) : "00") + ":" + (minutes ? (minutes > 9 ? minutes : "0" + minutes) : "00") + ":" + (seconds > 9 ? seconds : "0" + seconds);
		timer();
	};

	var timer = function() {
		t = setTimeout(add, 1000);
		$('#start').css("display", "none");
		$('#stop').css("display", "inline-block");
	};

	start.onclick = timer;

	stop.onclick = function() {
		clearTimeout(t);
		$('#stop').css("display", "none");
	}

	cancel.onclick = function() {
		console.log("in cancel function")
		stop.onclick();
		clear.onclick();
	}

	clear.onclick = function() {
		h1.textContent = "00:00:00";
		seconds = 0; minutes = 0; hours = 0;
		$('#start').css("display", "inline-block");
		$('#stop').hide();
		stop.onclick();
	}

	submit.onclick = function(e, location_id) {
		stop.onclick();

		var duration = seconds + (hours*60);

		var durationObj = {
			duration: { duration: duration, location_id: id, user_id: 2}
		}

		$.ajax({
			url: '/locations/1/duration',
			type: 'post',
			data: durationObj,
			dataType: 'json'
		}).success(function(data){
			pinCardDurationUpdate(data)
		}).fail(function(data){
		});

		clear.onclick();
	};
};

var pinCardDurationUpdate = function (location) {
	$('.average_badge').html(location.average_duration);
	$('.latest_badge').html(location.latest_duration);
}
