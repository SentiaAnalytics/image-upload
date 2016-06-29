fs = require 'fs'
path = require 'path'
mkdirp = require 'mkdirp'

exports.send = (res, status, data) --> res.status(status).send(data)

export andThen = (fn, promise) --> promise.then fn

export parseQuery = (value) ->
  switch
    when value == 'true' then true
    when value == 'false' then false
    when !Number.isNaN Number value then Number value
    else value

export toString = (x) -> x.toString()

export writeFile = (filepath, inputStream) -->
  new Promise (resolve, reject) ->
    fileStream = inputStream.pipe fs.createWriteStream filepath

    inputStream
      .on 'end', -> resolve(fileStream.path)
      .on 'error', reject

createFolder = (folderpath) ->
  new Promise (resolve, reject) ->
    mkdirp folderpath, (err) -> if err then reject err else resolve folderpath

export writeFileToFolder = (inputStream, folder, filename) -->
  createFolder folder
    .then (folderPath) ->
      writeFile (path.join folderPath, filename), inputStream
