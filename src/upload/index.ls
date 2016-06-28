{last, split, map, flip, composeP} = require 'ramda'
{writeFileToFolder, send, andThen} = require '../util'
assert = require 'assert'
path = require 'path'
fs = require 'fs'
log = require '../logger'
PORT = process.env.PORT
ROOT_FOLDER = path.join __dirname, '../../public/files'
CONTENT_DISPOSITION_ERROR = """
  Invalid Content-Disposition header
  please ensure that you include a Content-Disposition header on the form: 'attachment; filename="<name>.jpg"'
"""

getFileName = (contentDisposition) ->
  return Promise.reject CONTENT_DISPOSITION_ERROR unless contentDisposition

  [_, filename] = if contentDisposition.match /filename="(.+\.(.{3,4}))"/
    then that
    else []

  if filename then Promise.resolve that else Promise.reject CONTENT_DISPOSITION_ERROR

module.exports = (req, res) ->
  {camera} = req.params
  folder = path.join ROOT_FOLDER, camera
  imageUrl = (filePath) -> "http://#{req.hostname}/files/#{camera}/#{last split "/", filePath}"

  result = andThen (log "image-upload:success")
    <| andThen imageUrl
    <| andThen (writeFileToFolder req, folder)
    <| getFileName req.headers['content-disposition']

  onError = (err) ->
    log 'image-upload:error', err
    send res, 500, err

  result.then (send res, 200), onError
