import http from 'http'
import express from 'express'
import socketio from 'socket.io'
import path from 'path'

import { sendArduino } from './helpers/arduinoSerial'


// Camera Config
let v4l2camera = null;
let cam;
let feed = null;
try {
  v4l2camera = require("v4l2camera");
  cam = new v4l2camera.Camera("/dev/video0");
  cam.configSet({width: 352, height: 288}); // Try different sizes
  cam.start();
  cam.capture(function loop() {
    cam.capture(loop);
  });
} catch (err) {
  console.log("The camera module only works in a Pi Enviroment")
}


// App Config
const app = express();
const server = http.Server(app);
const io = socketio(server);
const port = process.env.PORT || 3001;

const staticFiles = express.static(path.join(__dirname, '../../../client/build'));
app.use(staticFiles);
app.get('/video-feed', (req, res) => {
  let buffer = Buffer(cam.toYUYV());
  res.set({
    "content-type": "image/vnd-raw",
    "content-length": buffer.length,
  });
  res.send(buffer);
});
app.use('/*', staticFiles);

server.listen(port, () => {console.log(`Listening on ${port}`); });


// Socket Config
io.on('connection', (socket) => {
  console.log('User Connected')

  socket.on('control input', (data) => {
    sendArduino(data);
  })
});
