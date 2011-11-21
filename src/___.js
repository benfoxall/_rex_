(function(window){
	"use strict";
	
	var aslice = Array.prototype.slice,
			events, // the events that are stored
			inprogress, // events that are start/stopping
			dateOffset; // the time offset from the reset tracker
	
	// returns millis from start to now
	var time = function(){
			return +new Date() - dateOffset;
	};
	
	// add an event to the object
	var add = function(name, timestamp){
		if(!events[name]) events[name] = []
		events[name].push(timestamp);
	};
	
	
	// a new logging event
	var ___ = function(name, fn){
		if(!(this instanceof ___))
			return new ___(name, fn);
			
		// do nothing (for setting options, etc)
		if(!name)
			return this;
		
		switch(fn){
			case undefined:
				add(name,time());
				return;
			
			case 'start':
				inprogress[name] = time();
				return;
			
			case 'stop':
				add(name, [inprogress[name], time()]);
				return;
			
			default:
				return function(){
					var start = time();
					var returnValue = fn.apply(fn,aslice.call(arguments,0));
					add(name,[start,time()])
					return returnValue;
				}
			
		}
	};
	
	___.prototype.events = function(){
		//make a clone of the events and return that
		var clone = {};
		for(var i in events){
			if(events.hasOwnProperty(i))
				clone[i] = aslice.call(events[i]);
		}
		return clone;
	};
	
	// define and call reset 
	(___.prototype.reset = function(){
		events = {};
		inprogress = {};
		dateOffset = +new Date();
	})();
	
	
	window.___ = ___;
	
})(window)