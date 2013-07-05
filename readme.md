\_rex\_ is for logging in javascript

(still in early development)

#Usage


### basic events

```js
_rex_('something happened');

_rex_('something else happened');

// include emitters/console.js file too
_rex_.emit('console');
```

… will store these events to a log

### wrapping functions


```js
var an_fn = function(){…};

an_fn = _rex_('fn happened',fn);
```

… will store the start/finish time of 'an\_fn'

### start/finish times


```js
_rex_('my event','start');

…some other stuff

_rex_('my event','stop');
```

… will store the start/finish time of 'my event'


## Other

Restart the tracker:

```
_rex_().reset()
```

View the stored events:

```js
_rex_().events()
```


## Sending events to a server

(Run the the collector node app: `node beacon`)

```js
// include emitters.beacon file too
_rex_.emit('beacon', {url:'http://192.168.what.ever:4444'})
```

## Testing

To run the tests, install jasmine and rack-asset-compiler `gem install jasmine rack-asset-compiler` and then run `rake jasmine` to start the server.
