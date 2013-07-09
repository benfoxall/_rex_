/*jslint newcap: true, nomen: true, vars: true */
/*global _rex_ */
(function (_rex_) {
    "use strict";
    _rex_.emitter('console', function (events) {
        var i, j;
        for (i in events) {
            if (events.hasOwnProperty(i)) {
                for (j = 0; j < events[i].length; j += 1) {
                    var time = events[i][j];
                    var seconds;
                    if (time[1]) {
                        // start stop
                        seconds = time[0] / 1000;
                        var duration = (time[1] - time[0]) / 1000;
                        console.log('@' + seconds + 's (' + duration + 's): ' + i);
                    } else {
                        seconds = events[i][j] / 1000;
                        console.log('@' + seconds + 's: ' + i);
                    }

                }
            }
        }
    });
}(_rex_));
