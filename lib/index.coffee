Log = require('debug')('express:routes-manager')

Path = require 'path'

_ = require 'lodash'
express = require 'express'

extractMethodFromPath = (path) ->
  s = path.split " "
  if s.length is 1
    method: null
    path: path
  else
    method: s[0].toLowerCase()
    path: s[1]

module.exports = (app, opts={}) ->
  Log "initialize express-routes-manager"
  
  app.loadRoutes = (routes, parent='/') ->
    return Log "no routes loaded" unless _.isPlainObject routes
    
    Log "load Routes: "+Object.keys routes
    
    loadRoute = (path, action, method) ->
      Router = express.Router()
      Log "load Route for "+(if method? then method else "use")+" #{path}"
      if method?
        Router[method] path, action
      else
        Router.use path, action
        
      app.use Router
    
    for path, route of routes
      {method, path} = extractMethodFromPath path
      path = Path.join parent, path
      
      if method is 'scope'
        app.loadRoutes route, path
      else if method is 'mount'
        app.use path, route
      else if _.isFunction route
        loadRoute path, route, method
      else if _.isPlainObject route
        Log "Plain?"
      else
        throw new Error "Illegal Statement for route #{path}"