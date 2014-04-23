class Router
  # An array to hold our route objects
  @routes = []

  @buildRegexString: (path) ->
    path.replace(/\//g, "\\/").replace(/:(\w*)/g,"(\\w*)")

  @add: (path, func) ->
    # A route has;
    # 1. params in the form of splats like :year/:month/:day. 
    #    These are extracted and passed to the callback function as arguments
    # 2. A regular expression to match the current path agains
    # 3. A callback function
    @routes.push {
      params: path.match(/:(\w*)/g)
      regex: new RegExp(@buildRegexString(path))
      callback: func
    }

  # Take a url to process. Default to the current path
  @process: (url = window.location.pathname) ->
    # Loop through the routes
    for route in @routes
      # math the current url against the route's regex
      results = url.match(route.regex)
      
      # Do we have a match?
      if results?
        index = 1
        namedParams = {}

        # Does this route have params defined? if so split them up and
        # push the results onto namedParams
        if route.params?
          for name in route.params
            namedParams[name.slice(1)] = results[index++]
            
        route.callback(namedParams)

describe "Router#process", ->
    api = result = ""
    beforeEach ->
      api = {
        testCallBack: (params)->
          console.log "testCallBack"
      }
      spyOn(api, "testCallBack").andCallFake( (params)->
        result = params
      )
      
      Router.add blog_route, api.testCallBack
      Router.process("/blog/2012/01/01")
    
    it "should find the route and execute the callback", ->
      expect(api.testCallBack).toHaveBeenCalled()
      
    it "should execute the callback with the correct parameters", ->
      expect(result).toEqual({ year: "2012", month: "01", day: "01"})