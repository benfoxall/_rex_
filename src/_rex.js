/*global window */
/*jslint newcap: true, nomen: true, vars: true */
(function (window) {
    "use strict";

    var aslice = Array.prototype.slice,
        events, // the events that are stored
        inprogress, // events that are start/stopping
        dateOffset, // the time offset from the reset tracker
        emitters, // where/how the events will be sent
        activeEmitters; // an array of the keys of which to emit

    // returns millis from start to now
    var time = function () {
        return +new Date() - dateOffset;
    };

    // add an event to the object
    var add = function (name, timestamp) {
        if (!events[name]) {
            events[name] = [];
        }
        events[name].push(timestamp);
    };


    // a new logging event
    var _rex_ = function (name, fn) {
        if (!(this instanceof _rex_)) {
            return new _rex_(name, fn);
        }

        // do nothing (for setting options, etc)
        if (!name) {
            return this;
        }

        switch (fn) {
        case undefined:
            add(name, time());
            return;

        case 'start':
            inprogress[name] = time();
            return;

        case 'stop':
            add(name, [inprogress[name], time()]);
            return;

        default:
            return function () {
                var start = time();
                var returnValue = fn.apply(fn, aslice.call(arguments, 0));
                add(name, [start, time()]);
                return returnValue;
            };

        }
    };

    _rex_.prototype.events = function () {
        //make a clone of the events and return that
        var clone = {}, i;
        for (i in events) {
            if (events.hasOwnProperty(i)) {
                clone[i] = aslice.call(events[i]);
            }
        }
        return clone;
    };

    _rex_.prototype.reset = function () {
        events = {};
        inprogress = {};
        emitters = {};
        activeEmitters = [];
        dateOffset = +new Date();
    };

    // reset the initial tracker
    _rex_.prototype.reset();

    // Reset the date offset (keeping all the emitters, etc in place)
    _rex_.prototype.resetTime = function () {
        dateOffset = +new Date();
    };

    // adding of emitters
    _rex_.emitter = function (name, fn) {
        emitters[name] = fn;
    };

    // enabling an emitter
    _rex_.emit = function (name, options) {
        activeEmitters.push([name, options || {}]);
    };

    // force flushing to the emitters
    _rex_.flush = function () {
        var i;
        for (i = 0; i < activeEmitters.length; i += 1) {
            var name = activeEmitters[i][0];
            var settings = activeEmitters[i][1];

            var emitterfn = emitters[name];
            if (emitterfn) {
                emitterfn.prototype.options = settings;
                events = new emitterfn(events) || events;
            }
        }
    };

    (function poll() {
        var x;
        for (x in events) {
            if (events.hasOwnProperty(x)) {
                _rex_.flush();
                break;
            }
        }
        setTimeout(poll, 500);
    }());

    window._rex_ = _rex_;

}(window));
