routesmanager = require '..'

express = require 'express'
supertest = require 'supertest'

describe "Lib", ->
  
  request = null
  
  before ->
    app = express()
    blog = express()
    
    routesmanager app
    routesmanager blog
    
    app.loadRoutes
      'get /': (req, res) -> res.send "Get Hello"
      'post /': (req, res) -> res.send "Post Hello"
      'scope /api':
        'get /': (req, res) -> res.json info: 'ok'
        'post /foo': (req, res) -> res.json info: 'bar'
      'mount /blog': blog
      
    blog.loadRoutes
      'get /': (req, res) -> res.send "blog"
      'get /archive': (req, res) -> res.send "archive"
    
    request = supertest app
    
  context "GET /", ->
    it "should respond 200 and Get Hello", (done) ->
      request.get '/'
      .expect 200
      .expect "Get Hello"
      .end done
      
  context "POST /", (done) ->
    it "should respond 200 and Post Hello", (done) ->
      request.post '/'
      .expect 200
      .expect "Post Hello"
      .end done
      
  context "GET /api", (done) ->
    it "should respond 200 and info: 'ok'", (done) ->
      request.get '/api'
      .expect 200
      .expect info: 'ok'
      .end done
      
  context "POST /api/foo", (done) ->
    it "should respond 200 and info: 'bar'", (done) ->
      request.post '/api/foo'
      .expect 200
      .expect info: 'bar'
      .end done
      
  context "GET /blog", ->
    it "should respond 200 and blog", (done) ->
      request.get '/blog'
      .expect 200
      .expect "blog"
      .end done
      
  context "GET /blog/archive", ->
    it "should respond 200 and archive", (done) ->
      request.get '/blog/archive'
      .expect 200
      .expect "archive"
      .end done