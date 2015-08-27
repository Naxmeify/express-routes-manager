module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    mochacli:
      options:
        reporter: 'spec'
        compilers: ['coffee:coffee-script/register']
        require: ['should']
        ui: 'bdd'
        quiet: false
        growl: false
        env:
          NODE_ENV: 'test'
          # DEBUG: 'express:*' # activate this only if u wanna see it
      all:
        options:
          files: ['test/**/*.coffee']
          
  grunt.loadNpmTasks 'grunt-mocha-cli'
  grunt.registerTask 'test', ['mochacli']