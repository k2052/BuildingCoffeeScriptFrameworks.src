(function() {
  var Foo;

  Foo = (function() {
    function Foo() {}

    return Foo;

  })();

  if (typeof window !== "undefined" && window !== null) {
    window.Foo = Foo;
  }

}).call(this);
