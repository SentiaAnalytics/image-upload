mkdirp = require 'mkdirp'
path = require 'path'

mkdirp (path.join __dirname, 'public/files/test'), (err) ->
  console.log 'DONE', err
