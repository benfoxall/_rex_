delay = (ms, func) -> setTimeout func, ms

beforeEach ->
  _tracks_().reset()


describe 'emitters', ->
  
  it 'can accept new emitters', ->
    
    _tracks_.emitter 'test', ->
      
  it 'will only emit once activated', ->
      capture = jasmine.createSpy 'capture'
      _tracks_.emitter 'test', capture
      _tracks_.flush()
      
      expect(capture)
        .wasNotCalled()
      
      # enable the emitter
      _tracks_.emit 'test'
      _tracks_.flush()
      
      expect(capture)
        .toHaveBeenCalled()
  
  it 'calls emitters on flush', ->
    
    capture = jasmine.createSpy 'capture'
    _tracks_.emitter 'test', capture
    _tracks_.emit 'test'
    
    expect(capture)
      .wasNotCalled()
    
    _tracks_.flush()
    
    expect(capture)
      .toHaveBeenCalled()
    
  it 'passes events on to emitter', ->
    
    capture = jasmine.createSpy 'capture'
    _tracks_.emitter 'test', capture
    _tracks_.emit 'test'
    
    _tracks_.flush()
    
    expect(capture)
      .toHaveBeenCalledWith({})
    
    _tracks_ 'hello'
    _tracks_.flush()
    
    expect(capture.mostRecentCall.args[0].hello)
      .toBeDefined('')
    
    console.log(capture.mostRecentCall)
    
  it 'should update the events as returned from the emitter', ->
    
    _tracks_.emitter 'test', -> {test:[20]}
    _tracks_.emit 'test'
    
    expect(_tracks_().events()).toEqual({})
    
    _tracks_.flush()
    
    expect(_tracks_().events()).toEqual({test:[20]})
  
  it 'should make options be available to the emitter as this.options', ->
    
    _tracks_.emitter 'test', -> 
      expect(this.options.mySetting)
        .toBe('settingValue');
    
    _tracks_.emit 'test', {mySetting:'settingValue'}
    
    _tracks_.flush()
    



describe "_tracks_ client", ->
  
  it 'is availible', ->
    expect(_tracks_)
      .toBeDefined()

  it "has an accessible store of events", ->
 
    expect(_tracks_().events)
      .toBeDefined()
    expect(_tracks_().events())
      .toEqual({})
  
  it "gives access to a clone of the events", ->
    # events = _tracks_().events
    expect(_tracks_().events())
      .toNotBe(_tracks_().events())



describe "simple logging", ->

  it "logs an event", ->
    _tracks_ 'my-event'
    
    e = _tracks_().events()['my-event']
    
    expect(e)
      .toBeDefined()
      
  it 'stores the time of an event', ->
    
    _tracks_ 'a'
    
    delay 200, ->
      _tracks_ 'a'
    
    fin = -> 
      events = _tracks_().events().a
      
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
    
    _tracks_ 'a'
    _tracks_ 'a'
    _tracks_ 'b'
    
    events = _tracks_().events();
    
    expect(events.a.length)
      .toBe(2)
      
    expect(events.b.length)
      .toBe(1)



describe 'timed functions', ->
    
  it 'should return a wrapped function', ->
    fn = _tracks_ 'functEvent', -> 'odelay!'

    expect(fn())
      .toBe('odelay!')
  
  
  it 'should be in the events', ->
    
    (_tracks_ 'functEvent', -> )()
    
    events = _tracks_().events()
    
    expect(events.functEvent)
      .toBeDefined()
  
  
  it 'should still work when reset', ->
    
    fn = _tracks_ 'functEvent', -> 'odelay!'
    
    _tracks_().reset()
    
    expect(fn())
      .toBe('odelay!')



describe 'start/stop events', ->

  it 'should not appear if not stopped', ->
  
    _tracks_ 'e1', 'start'
    
    expect(_tracks_().events().e1)
      .toBeUndefined()

  describe 'when stopped', ->

    it 'should be logged', ->
      
      _tracks_ 'e1', 'start'
      _tracks_ 'e1', 'stop'
      
      expect(_tracks_().events().e1.length)
        .toBe(1)

    it 'should have start/stop times', ->
      
      _tracks_ 'e1', 'start'
      _tracks_ 'e1', 'stop'
      
      expect(_tracks_().events().e1[0].length)
        .toBe(2)

