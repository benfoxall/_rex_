/*jslint newcap: true, nomen: true, vars: true */
/*global _rex_, Image */
_rex_.emitter('beacon', function (events) {
    "use strict";
    (new Image()).src = options.url +  '/?' + encodeURIComponent(JSON.stringify(events));
});
