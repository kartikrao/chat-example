path = require 'path'
express = require 'express'
errorHandler = require 'errorhandler'
app = express()

app.set 'views', path.join(__dirname, 'views')
app.set('view engine', 'jade')
app.use errorHandler()

http = require('http').Server(app)
io = require('socket.io')(http)

app.get '/', (req, res) -> res.render "chatwindow"

io.on 'connection', (socket) ->
  socket.on 'chat message', (msg) -> 
  	io.emit('chat message', msg)

http.listen 3000, -> console.log 'listening on *:3000'