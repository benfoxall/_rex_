_rex_.emitter('beacon', function(events){
  (new Image).src= options.url +  '/?' + JSON.stringify(events)
});
