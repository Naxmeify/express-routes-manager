routesmanager = require '..'

express = require 'express'
supertest = require 'supertest'

describe "Named Action", ->
  
  request = null
  
  app = null
  
  routesApp = ->
    'get /': 'index'
    
  Index = (req, res) -> res.send 'INDEX'
    
  before ->
    app = express()
    routesmanager app
    routesmanager.addAction 'index', Index
    app.loadRoutes routesApp()
    
    request = supertest app
    
  context "GET /", ->
    it "should response 200 and INDEX as defined in named actions", (done) ->
      request.get '/'
      .expect 200
      .expect 'INDEX'
      .end done