\_tracks\_ is for logging in javascript

(still in early development)

#Usage


### basic events

    _tracks_('something happened');

    _tracks_('something else happened');

… will store these events to a log

### wrapping functions

    var an_fn = function(){…};

    an_fn = _tracks_('fn happened',fn);

… will store the start/finish time of 'an\_fn'

### start/finish times

    _tracks_('my event','start');
    
    …some other stuff
    
    _tracks_('my event','stop');

… will store the start/finish time of 'my event'


## Other

Restart the tracker:

    _tracks_().reset()

View the stored events:

    _tracks_().events()


## Testing

To run the tests, install jasmine and rack-asset-compiler `gem install jasmine rack-asset-compiler` and then run `rake jasmine` to start the server.