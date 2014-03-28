(function() {
  describe("Foo", function() {
    return it("should create a new foo instance", function() {
      var foo;
      foo = new Foo();
      return foo.should.be.an.instanceOf(Foo);
    });
  });

}).call(this);
