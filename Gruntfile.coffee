module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON "./package.json"

    meta:
      file: "<%= pkg.name %>"
      endpoint: 'package',
      banner: '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
              ' <%= pkg.homepage %>\n' +
              ' Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>' +
              ' - Licensed under <%= pkg.license %> */\n'

    resources:
      test_dependecies: [
        'bower_components/mocha/mocha.js',
        'bower_components/chai/chai.js',
        'bower_components/sinon-chai/lib/sinon-chai.js',
        'bower_components/sinon/lib/sinon.js'
      ]

      src: [
        'src/*.coffee',
      ]

      spec: [
        'spec/*_spec.coffee'
      ]

    coffee:
      options:
        join: true
      src:
        files:
          '<%= pkg.name %>.debug.js': '<%= resources.src %>'
      test:
        files:
          'test/js/<%= pkg.name %>.js': '<%= resources.src %>'
          'test/spec/spec.js': ['<%= resources.spec %>']

    uglify:
      options:
        compress: false
        banner: '<%= meta.banner %>'
      endpoint:
        files:
          '<%=meta.file%>.js': '<%= meta.file %>.debug.js'

    concat:
      options:
        separator: ";"
      test:
        src: '<%= resources.test_dependecies%>'
        dest: 'test/js/lib.js'

    watch:
      src:
        files: '<%= resources.src %>'
        tasks: ['coffee:src', 'uglify']
    
    mocha:
      test:
        src: [ 'test/test.html' ],
        options:
          # Select a Mocha reporter
          # http://visionmedia.github.com/mocha/#reporters
          reporter: 'Spec',

          # Indicates whether 'mocha.run()' should be executed in
          # 'bridge.js'. If you include `mocha.run()` in your html spec,
          # check if environment is PhantomJS. See example/test/test2.html
          run: true,

          # Override the timeout of the test (default is 5000)
          timeout: 10000

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-mocha'

  grunt.registerTask 'default', ['coffee:src', "uglify"]
  grunt.registerTask 'spec', ['coffee:test', 'concat:test', 'mocha:test']
