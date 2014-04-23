chai = require("chai")
chai.should()

moduleKeywords = ['included', 'extended']
class Module
  @include: (obj) ->
    throw new Error('include(obj) requires obj') unless obj

    for key, value of obj.prototype when key not in moduleKeywords
      @::[key] = value

    obj.included?.apply(this)
    @

  @extend: (obj) ->
    throw new Error('extend(obj) requires obj') unless obj

    for key, value of obj when key not in moduleKeywords
      @[key] = value

    obj.extended?.apply(this)
    
    @

class Animal
  talk: () ->
    return "growl!"

  @isInsect: () ->
    return false

class Cat extends Module
  @include Animal
  @extend Animal

it 'should not be an insect', ->
  Cat.isInsect().should.equal false

it 'should be able to talk', ->
  cat = new Cat
  cat.talk().should.equal "growl!"
  