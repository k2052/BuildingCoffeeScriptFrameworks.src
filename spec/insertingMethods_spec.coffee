chai = require("chai")
chai.should()

meow = ->
  return "meow"

class Cat
	# Empty Class
	
Cat['meow'] = meow

it "should meow", ->
  Cat.meow().should.equal "meow"

Cat::['meow'] = meow

it "should meow", ->
  cat = new Cat()
  cat.meow().should.equal "meow"