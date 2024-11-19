import SerialPort from 'serialport'

let issues = false;
const port = new SerialPort('/dev/ttyACM0', { baudRate: 9600 }, (err) => {
  if (err) { issues = true; console.log("Cannot connect to Arduino through ttyACM0") }
});

export function sendArduino(CODE) {
  if (issues) return;
  port.write(CODE);
}