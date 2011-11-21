delay = (ms, func) -> setTimeout func, ms

beforeEach ->
  ___().reset()



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
        expect(events[0]/10).
          toBeCloseTo(0,0)
        expect(events[1]/10).
          toBeCloseTo(20,0)
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

  
  
  
  
  
  
  
  