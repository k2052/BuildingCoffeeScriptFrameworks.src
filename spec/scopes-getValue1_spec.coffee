chai = require("chai")
chai.should()

v = 1
getValue = ->
  return v

v = 2

it 'should return 2', ->
  getValue().should.equal 2
