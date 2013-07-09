_rex_.emitter('beacon', function(events){
  (new Image).src= options.url +  '/?' + encodeURIComponent(JSON.stringify(events));
});
