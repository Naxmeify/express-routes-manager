# express-routes-manager

[![Build Status](https://travis-ci.org/Naxmeify/express-routes-manager.svg?branch=master)](https://travis-ci.org/Naxmeify/express-routes-manager)

[![NPM](https://nodei.co/npm/express-routes-manager.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/express-routes-manager/)

## Installation

```
$ npm i --save express-routes-manager
```

## Usage
```CoffeeScript
express = require 'express'
routesmanager = require 'express-routes-manager'
app = express()
blog = express()

routesmanager app
routesmanager blog

app.loadRoutes
  'get /': (req, res) -> res.send "Get Hello"
  'post /': (req, res) -> res.send "Post Hello"
  'get /array': [
    (req, res, next) ->  
      res.locals.heyho = "HEYHO"
      next()
    (req, res) ->
      res.send res.locals.heyho
  ]
  'get /middleware': [middleware, action]
  'scope /api':
    # this will used as middleware for whole scope
    '/': [middleware1, middleware2]
    
    'get /': (req, res) -> res.json info: 'ok'
    'post /foo': (req, res) -> res.json info: 'bar'
  'mount /blog': blog
  
blog.loadRoutes
  'get /': (req, res) -> res.send "blog"
  'get /archive': (req, res) -> res.send "archive"
```

## Contributing

Issue, Fork, Pull Request - whatever you want to.

## License

The MIT License (MIT)

Copyright (c) 2015 MRW Neundorf <matt@nax.me>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

