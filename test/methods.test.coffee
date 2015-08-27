routesmanager = require '..'

express = require 'express'
supertest = require 'supertest'

describe "Route Methods", ->
  
  request = null
  
  app = null
  subapp = null
  
  before ->
    app = express()
    subapp = express()
    
    routesmanager app
    routesmanager subapp
    
    request = supertest app
  
  primary = 
    path: '/'
    action: 'send'
    
  tests = [
    {method: 'checkout', status: 200, body: 'checkout'}
    {method: 'connect', status: 200, body: 'connect', skip: true}
    {method: 'copy', status: 200, body: 'copy'}
    {method: 'delete', status: 200, body: 'delete'}
    {method: 'get', status: 200, body: 'get'}
    {method: 'head', status: 200, body: ''}
    {method: 'lock', status: 200, body: 'lock'}
    {method: 'merge', status: 200, body: 'merge'}
    {method: 'mkactivity', status: 200, body: 'mkactivity'}
    {method: 'mkcol', status: 200, body: 'mkcol'}
    {method: 'move', status: 200, body: 'move'}
    {method: 'm-search', status: 200, body: 'm-search'}
    {method: 'notify', status: 200, body: 'notify'}
    {method: 'options', status: 200, body: 'CHECKOUT'}
    {method: 'patch', status: 200, body: 'patch'}
    {method: 'post', status: 200, body: 'post'}
    {method: 'propfind', status: 200, body: 'propfind'}
    {method: 'proppatch', status: 200, body: 'proppatch'}
    {method: 'purge', status: 200, body: 'purge'}
    {method: 'put', status: 200, body: 'put'}
    {method: 'report', status: 200, body: 'report'}
    {method: 'search', status: 200, body: 'search'}
    {method: 'subscribe', status: 200, body: 'subscribe'}
    {method: 'trace', status: 200, body: 'trace'}
    {method: 'unlock', status: 200, body: 'unlock'}
    {method: 'unsubscribe', status: 200, body: 'unsubscribe'}
  ]
  
  tests.forEach (test) ->
    context "#{test.method} #{primary.path}", ->
      before ->
        routes = {}
        routes[test.method+" "+primary.path] = (req, res) -> res[primary.action] test.body
        
        app.loadRoutes routes
      
      tm = (done) ->
        request[test.method.toLowerCase()] primary.path
        .expect test.status
        .expect test.body
        .end done
      
      unless test.skip
        it "should reponse status #{test.status} and body '#{test.body}'", tm
      else
        it.skip "should reponse status #{test.status} and body '#{test.body}'", tm