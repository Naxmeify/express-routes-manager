routesmanager = require '..'

express = require 'express'
supertest = require 'supertest'

describe "Lib", ->
  
  request = null
  
  app = null
  subapp = null
  
  middlewaretext = "i am a impressive middleware, but next will handle it"
  middleware = (req, res, next) ->
    res.locals.text = middlewaretext
    next()
  middlewareaction = (req, res) ->
    res.send res.locals.text
    
  action = (req, res) ->
    res.send "action"
  
  routesApp = ->
    'get /': (req, res) -> res.send "Get Hello"
    'post /': (req, res) -> res.send "Post Hello"
    'get /array': [
      (req, res, next) ->  
        res.locals.heyho = "HEYHO"
        next()
      (req, res) ->
        res.send res.locals.heyho
    ]
    'get /middleware': [middleware, middlewareaction]
    'get /action': action
    'scope /api':
      'get /': (req, res) -> res.json info: 'ok'
      'post /foo': (req, res) -> res.json info: 'bar'
    'mount /subapp': subapp

  routesSubApp = ->
    'get /': (req, res) -> res.send "subapp"
    'get /archive': (req, res) -> res.send "archive"
  
  before ->
    app = express()
    subapp = express()
    
    routesmanager app
    routesmanager subapp
    
    app.loadRoutes routesApp()
    subapp.loadRoutes routesSubApp()
    
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
      
  context "GET /array", (done) ->
    it "should respond 200 and HEYHO", (done) ->
      request.get '/array'
      .expect 200
      .expect "HEYHO"
      .end done
      
  context "GET /middleware", (done) ->
    it "should respond 200 and defined middlewaretext", (done) ->
      request.get '/middleware'
      .expect 200
      .expect middlewaretext
      .end done
      
  context "GET /action", (done) ->
    it "should respond 200 and action", (done) ->
      request.get '/action'
      .expect 200
      .expect "action"
      .end done
      
  context "SCOPE /api", ->
    context "GET /", (done) ->
      it "should respond 200 and info: 'ok'", (done) ->
        request.get '/api'
        .expect 200
        .expect info: 'ok'
        .end done
        
    context "POST /foo", (done) ->
      it "should respond 200 and info: 'bar'", (done) ->
        request.post '/api/foo'
        .expect 200
        .expect info: 'bar'
        .end done
  
  context "MOUNT /subapp", ->
    context "GET /", ->
      it "should respond 200 and subapp", (done) ->
        request.get '/subapp'
        .expect 200
        .expect "subapp"
        .end done
        
    context "GET /archive", ->
      it "should respond 200 and archive", (done) ->
        request.get '/subapp/archive'
        .expect 200
        .expect "archive"
        .end done
  