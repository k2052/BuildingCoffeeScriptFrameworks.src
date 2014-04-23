chai      = require("chai")
sinon     = require("sinon")
sinonChai = require("sinon-chai")
chai.should()
chai.use(sinonChai)

# Very simple Mediator in Coffeescript
# Based on the Pub/Sub implementation by rpflorence (https://github.com/rpflorence)

class PubSub
  constructor: ->
    @channels = {}

  subscribe: (name, callback) ->
    @channels[name] = [] unless @channels[name]?
    @channels[name].push context: @, callback: callback
    @

  unsubscribe: (name, callback) ->
    for sub, i in @channels[name]
      @channels[name].splice(i, 1) if sub.callback == callback

  publish: (name, data...) ->
    for sub in @channels[name]
      sub.callback.apply(sub.context, data)

describe 'PubSub', ->
  data     = null
  spy      = null
  pubSub   = null
   
  beforeEach ->
    data   = 'cats'
    pubSub = new PubSub()
    spy    = sinon.spy() 
   
  it 'subscribes and publishes', ->
    pubSub.subscribe 'channel', spy
    pubSub.publish   'channel', data
    spy.should.have.been.calledWith(data)
   
  it 'handles unsubscribe', ->
    pubSub.subscribe   'channel', spy
    pubSub.unsubscribe 'channel', spy
    pubSub.publish     'channel', data
    spy.called.should.be.false
