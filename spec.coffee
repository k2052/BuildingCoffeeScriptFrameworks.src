chai = require("chai")
chai.should()

describe "dog", ->
  it "should clone a dog and allow us to change the legs count on all dogs", ->
    Object.prototype.clone = ->
      clone = Object.create(this)

      return clone

    Dog = ->
      name = undefined
      Dog.prototype.legs = 4

    dog1 = new Dog()
    dog1.name = "Jerry"
    dog2 = dog1.clone()
    dog2.name.should.equal "Jerry"
    dog2.legs.should.equal 4
    
    dog1.legs = 8
    dog2.legs.should.equal 8
    