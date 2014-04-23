chai = require("chai")
chai.should()

v = 1
getValue = do(v) ->
  ->  
    v

v = 2

it 'should return 1', ->
  getValue().should.equal 1
