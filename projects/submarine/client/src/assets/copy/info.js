export default [
  "Thanks for checking out our project. Here’s a bit of information of what our project consists of.",
  "We have 4 DC brush motors that are theoretically unaffected by water and 4 ESC controlling them. We have an Arduino Uno configuring them on start up and sending the specific signals to get the submarine moving. The Arduino is connected via usb to the Raspberry Pi.",
  "The Pi has a React/Node/Express server handling everything else. It serves this frontend interface and paints the camera feed onto a canvas that it recieves via web sockets. It also sends inputs that correspond to submarine movement via those same sockets. When the server recieves these inputs, it sends signals to the Arduino using our propreitary protocol.",
];
