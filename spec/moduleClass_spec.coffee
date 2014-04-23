chai = require("chai")
chai.should()

class Module
  @include: (obj) ->
    for key, value of obj.prototype
      @::[key] = value
      
  @extend: (obj) ->
    for key, value of obj
      @[key] = value
          
class Animal
  talk: ->
    return "growl!"

  @isInsect: () ->
    return false

class Cat extends Module
  @include Animal
  @extend Animal

it 'should not be an insect', ->
  Cat.isInsect().should.equal false

it 'should be able to talk', ->
  cat = new Cat()
  cat.talk().should.equal "growl!"

