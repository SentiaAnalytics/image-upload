express = require 'express'
uploadHandler = require './upload'
PORT = process.env.PORT

app = express!

app.use (req, res, next) ->
  console.log "REQUEST"
  next!

app.use express.static '/sentia'

app.get '/', (req, res) ->
  res.send """
    Sentia Image Upload
  """

app.post '/:camera' uploadHandler

app.listen PORT, ->
  console.log "server listening on port #{PORT}"
