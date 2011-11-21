\_\_\_ is for logging in javascript

(still in early development)

#Usage


### basic events

    ___('something happened');

    ___('something else happened');

… will store these events to a log

### wrapping functions

    var an_fn = function(){…};

    an_fn = ___('fn happened',fn);

… will store the start/finish time of 'an\_fn'

### start/finish times

    ___('my event','start');
    
    …some other stuff
    
    ___('my event','stop');

… will store the start/finish time of 'my event'


## Other

Restart the tracker:

    ___().reset()

View the stored events:

    ___().events()