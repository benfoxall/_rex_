delay = (ms, func) -> setTimeout func, ms

beforeEach ->
  ___().reset()


describe 'emitters', ->
  
  it 'can accept new emitters', ->
    
    ___.emitter 'test', ->
      
  it 'will only emit once activated', ->
      capture = jasmine.createSpy 'capture'
      ___.emitter 'test', capture
      ___.flush()
      
      expect(capture)
        .wasNotCalled()
      
      # enable the emitter
      ___.emit 'test'
      ___.flush()
      
      expect(capture)
        .toHaveBeenCalled()
  
  it 'calls emitters on flush', ->
    
    capture = jasmine.createSpy 'capture'
    ___.emitter 'test', capture
    ___.emit 'test'
    
    expect(capture)
      .wasNotCalled()
    
    ___.flush()
    
    expect(capture)
      .toHaveBeenCalled()
    
  it 'passes events on to emitter', ->
    
    capture = jasmine.createSpy 'capture'
    ___.emitter 'test', capture
    ___.emit 'test'
    
    ___.flush()
    
    expect(capture)
      .toHaveBeenCalledWith({})
    
    ___ 'hello'
    ___.flush()
    
    expect(capture.mostRecentCall.args[0].hello)
      .toBeDefined('')
    
    console.log(capture.mostRecentCall)
    
  it 'should update the events as returned from the emitter', ->
    
    ___.emitter 'test', -> {test:[20]}
    ___.emit 'test'
    
    expect(___().events()).toEqual({})
    
    ___.flush()
    
    expect(___().events()).toEqual({test:[20]})
  
  it 'should make options be available to the emitter as this.options', ->
    
    ___.emitter 'test', -> 
      expect(this.options.mySetting)
        .toBe('settingValue');
    
    ___.emit 'test', {mySetting:'settingValue'}
    
    ___.flush()
    



describe "___ client", ->
  
  it 'is availible', ->
    expect(___)
      .toBeDefined()

  it "has an accessible store of events", ->
 
    expect(___().events)
      .toBeDefined()
    expect(___().events())
      .toEqual({})
  
  it "gives access to a clone of the events", ->
    # events = ___().events
    expect(___().events())
      .toNotBe(___().events())



describe "simple logging", ->

  it "logs an event", ->
    ___ 'my-event'
    
    e = ___().events()['my-event']
    
    expect(e)
      .toBeDefined()
      
  it 'stores the time of an event', ->
    
    ___ 'a'
    
    delay 200, ->
      ___ 'a'
    
    fin = -> 
      events = ___().events().a
      
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
    
    ___ 'a'
    ___ 'a'
    ___ 'b'
    
    events = ___().events();
    
    expect(events.a.length)
      .toBe(2)
      
    expect(events.b.length)
      .toBe(1)



describe 'timed functions', ->
    
  it 'should return a wrapped function', ->
    fn = ___ 'functEvent', -> 'odelay!'

    expect(fn())
      .toBe('odelay!')
  
  
  it 'should be in the events', ->
    
    (___ 'functEvent', -> )()
    
    events = ___().events()
    
    expect(events.functEvent)
      .toBeDefined()
  
  
  it 'should still work when reset', ->
    
    fn = ___ 'functEvent', -> 'odelay!'
    
    ___().reset()
    
    expect(fn())
      .toBe('odelay!')



describe 'start/stop events', ->

  it 'should not appear if not stopped', ->
  
    ___ 'e1', 'start'
    
    expect(___().events().e1)
      .toBeUndefined()

  describe 'when stopped', ->

    it 'should be logged', ->
      
      ___ 'e1', 'start'
      ___ 'e1', 'stop'
      
      expect(___().events().e1.length)
        .toBe(1)

    it 'should have start/stop times', ->
      
      ___ 'e1', 'start'
      ___ 'e1', 'stop'
      
      expect(___().events().e1[0].length)
        .toBe(2)

