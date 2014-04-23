chai      = require("chai")
sinon     = require("sinon")
sinonChai = require("sinon-chai")
expect = chai.expect
chai.should()
chai.use(sinonChai)

class Events
  @_callbacks: {}

  @bind: (eventOrEvents, callback) ->
    # Takes the event string and split it into an array of events. Allows multiple events to passed using spaces as a delimiter 
    events = eventOrEvents.split(' ')

    # Pulls the callbacks from the current class if they exist, if not then default to an empty object
    calls = @hasOwnProperty('_callbacks') and @_callbacks or= {}

    # Loops over the events and sets the callbacks
    for name in events
      calls[name] or= []
      calls[name].push(callback)

    # Returns this to support chaining
    @

  @trigger: (args...) ->
    # Pull the event name from the first argument
    event = args.shift()

    # Copy the callbacks for this event into a list array. Return if there are no callbacks for this event
    list = @hasOwnProperty('_callbacks') and @_callbacks?[event]
    return unless list

    # Loop through each of the callbacks for this event and then call them with apply using the current class as the context
    for callback in list
      if callback.apply(@, args) is false
        break
    true

  @unbind: (event, callback) ->
    # If no event name is passed then unbind everything
    unless event
      @_callbacks = {}
      return @

    #  Pull a list of all the callbacks for this event. Return if there are no callbacks
    list = @_callbacks?[event]
    return @ unless list

    #  If no specific callback is passed then unbind all the callbacks for the event and return this
    unless callback
      delete @_callbacks[event]
      return @

    # Loop through the callbacks and when the callback to unbind is found splice it out.
    for cb, i in list when cb is callback
      list = list.slice()
      list.splice(i, 1)
      @_callbacks[event] = list
      break

    # Return this to support chaining
    @

class Animal extends Events

it "can bind/trigger events", ->
  spy = sinon.spy()
  Animal.bind 'animals:talking', spy
  Animal.trigger 'animals:talking'
  expect(spy).to.have.been.called
