(function(___){
	___.emitter('console', function(events){
		for(var i in events){
			if(events.hasOwnProperty(i)){
				for (var j=0; j < events[i].length; j++) {
					var time = events[i][j];
					var seconds;
					if(time[1]){
						// start stop
						seconds = time[0] / 1000;
						var duration = (time[1] - time[0]) / 1000;
						console.log('@' + seconds + 's ('+duration+'s): ' + i);
					} else {
						seconds = events[i][j] / 1000;
						console.log('@' + seconds + 's: ' + i);
					}
					
				}
			}
		}
	});
}(___));