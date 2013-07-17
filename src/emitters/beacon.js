_rex_.emitter('beacon', function(events){
  (new Image).src = this.options.url +  '/?' + encodeURIComponent(JSON.stringify(events));
});
