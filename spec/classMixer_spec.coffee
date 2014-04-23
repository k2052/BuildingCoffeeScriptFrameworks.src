chai = require("chai")
chai.should()

mixOf = (mixins...) ->
  mixed = class Mixed

  for mixin in mixins by -1 # earlier mixins override later ones
    for name, method of mixin:: # instance methods
      mixed::[name] = method

    for name, method of mixin # class methods
      mixed[name] = method  

  return mixed

class Otter
  hasFur: () ->
    return true

class Duck   
  hasBill: () ->
    return true 

class Platypus extends mixOf Otter, Duck

it 'should have fur and a bill', ->
  platypus = new Platypus()
  platypus.hasFur().should.equal true
  platypus.hasBill().should.equal true
