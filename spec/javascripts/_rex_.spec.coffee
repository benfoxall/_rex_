delay = (ms, func) -> setTimeout func, ms

beforeEach ->
  _rex_().reset()


describe 'emitters', ->
  
  it 'can accept new emitters', ->
    
    _rex_.emitter 'test', ->
      
  it 'will only emit once activated', ->
      capture = jasmine.createSpy 'capture'
      _rex_.emitter 'test', capture
      _rex_.flush()
      
      expect(capture)
        .wasNotCalled()
      
      # enable the emitter
      _rex_.emit 'test'
      _rex_.flush()
      
      expect(capture)
        .toHaveBeenCalled()
  
  it 'calls emitters on flush', ->
    
    capture = jasmine.createSpy 'capture'
    _rex_.emitter 'test', capture
    _rex_.emit 'test'
    
    expect(capture)
      .wasNotCalled()
    
    _rex_.flush()
    
    expect(capture)
      .toHaveBeenCalled()
    
  it 'passes events on to emitter', ->
    
    capture = jasmine.createSpy 'capture'
    _rex_.emitter 'test', capture
    _rex_.emit 'test'
    
    _rex_.flush()
    
    expect(capture)
      .toHaveBeenCalledWith({})
    
    _rex_ 'hello'
    _rex_.flush()
    
    expect(capture.mostRecentCall.args[0].hello)
      .toBeDefined('')
    
    console.log(capture.mostRecentCall)
    
  it 'should update the events as returned from the emitter', ->
    
    _rex_.emitter 'test', -> {test:[20]}
    _rex_.emit 'test'
    
    expect(_rex_().events()).toEqual({})
    
    _rex_.flush()
    
    expect(_rex_().events()).toEqual({test:[20]})
  
  it 'should make options be available to the emitter as this.options', ->
    
    _rex_.emitter 'test', -> 
      expect(this.options.mySetting)
        .toBe('settingValue');
    
    _rex_.emit 'test', {mySetting:'settingValue'}
    
    _rex_.flush()
    



describe "_rex_ client", ->
  
  it 'is availible', ->
    expect(_rex_)
      .toBeDefined()

  it "has an accessible store of events", ->
 
    expect(_rex_().events)
      .toBeDefined()
    expect(_rex_().events())
      .toEqual({})
  
  it "gives access to a clone of the events", ->
    # events = _rex_().events
    expect(_rex_().events())
      .toNotBe(_rex_().events())



describe "simple logging", ->

  it "logs an event", ->
    _rex_ 'my-event'
    
    e = _rex_().events()['my-event']
    
    expect(e)
      .toBeDefined()
      
  it 'stores the time of an event', ->
    
    _rex_ 'a'
    
    delay 200, ->
      _rex_ 'a'
    
    fin = -> 
      events = _rex_().events().a
      
      if events.length == 2
        expect(events[0]/20).
          toBeCloseTo(0,0)
        expect(events[1]/20).
          toBeCloseTo(10,0)
        true
      else
        false
      
    waitsFor fin, 'Event to be added', 750
  
  
  it "stores multiple events", ->
    
    _rex_ 'a'
    _rex_ 'a'
    _rex_ 'b'
    
    events = _rex_().events();
    
    expect(events.a.length)
      .toBe(2)
      
    expect(events.b.length)
      .toBe(1)



describe 'timed functions', ->
    
  it 'should return a wrapped function', ->
    fn = _rex_ 'functEvent', -> 'odelay!'

    expect(fn())
      .toBe('odelay!')
  
  
  it 'should be in the events', ->
    
    (_rex_ 'functEvent', -> )()
    
    events = _rex_().events()
    
    expect(events.functEvent)
      .toBeDefined()
  
  
  it 'should still work when reset', ->
    
    fn = _rex_ 'functEvent', -> 'odelay!'
    
    _rex_().reset()
    
    expect(fn())
      .toBe('odelay!')



describe 'start/stop events', ->

  it 'should not appear if not stopped', ->
  
    _rex_ 'e1', 'start'
    
    expect(_rex_().events().e1)
      .toBeUndefined()

  describe 'when stopped', ->

    it 'should be logged', ->
      
      _rex_ 'e1', 'start'
      _rex_ 'e1', 'stop'
      
      expect(_rex_().events().e1.length)
        .toBe(1)

    it 'should have start/stop times', ->
      
      _rex_ 'e1', 'start'
      _rex_ 'e1', 'stop'
      
      expect(_rex_().events().e1[0].length)
        .toBe(2)

