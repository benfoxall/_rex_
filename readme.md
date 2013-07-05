\_rex\_ is for logging in javascript

(still in early development)

#Usage


### basic events

    _rex_('something happened');

    _rex_('something else happened');
    
    // include the console emitter file too
    _rex_.emit('console');

… will store these events to a log

### wrapping functions

    var an_fn = function(){…};

    an_fn = _rex_('fn happened',fn);

… will store the start/finish time of 'an\_fn'

### start/finish times

    _rex_('my event','start');
    
    …some other stuff
    
    _rex_('my event','stop');

… will store the start/finish time of 'my event'


## Other

Restart the tracker:

    _rex_().reset()

View the stored events:

    _rex_().events()


## Testing

To run the tests, install jasmine and rack-asset-compiler `gem install jasmine rack-asset-compiler` and then run `rake jasmine` to start the server.
