chai = require("chai")
chai.should()

Cat = (name) ->
  this.name = name

cat = new Cat("Doug")

it 'should return the name', ->
  cat.name.should.equal "Doug"
