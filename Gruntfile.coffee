module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-mocha-test')

  grunt.initConfig
     mochaTest:
      test:
        options:
          reporter: 'spec',
          require: ['coffee-script/register']
        ,
        src: ['spec/**/*_spec.coffee']

  grunt.registerTask 'default', 'mochaTest'
