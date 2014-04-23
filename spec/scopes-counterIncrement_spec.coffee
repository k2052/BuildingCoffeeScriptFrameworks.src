chai = require("chai")
chai.should()

describe "counter", ->
  counter  = undefined
  this.val = undefined

  beforeEach ->
    this.val = undefined

    counter = {
      val: 0

      increment: () ->
        this.val += 1
    }

  it "should increment the counter", ->
    counter.val.should.equal 0
    counter.increment()
    counter.val.should.equal 1

  it "should fail to increment", ->
    inc = counter.increment
    inc()
    counter.val.should.equal 0

  it "should increment val on the global scope", ->
    this.val = 2

    inc = counter.increment
    inc.call(this)

    this.val.should.eq 3
    counter.increment()
    counter.val.should.equal 1
