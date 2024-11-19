// Protocol is implemented here
//             | Back | Off | Forward
// Front Left  |  A   |  B  |   C
// Front Right |  D   |  E  |   F
// Back  Left  |  G   |  H  |   I
// Back  Right |  J   |  K  |   L
export default function keyEventToCode(keyCode, down) {
  if (down) {
    switch (keyCode) {
      case "KeyW":
        return ["I", "L"];
      case "KeyA":
        return ["I", "J"];
      case "KeyS":
        return ["G", "J"];
      case "KeyD":
        return ["G", "L"];
      case "ArrowUp":
        return ["C", "F"];
      case "ArrowLeft":
        return ["C", "D"];
      case "ArrowDown":
        return ["A", "D"];
      case "ArrowRight":
        return ["A", "F"];
      default:
        return [];
    }
  } else {
    switch (keyCode) {
      case "KeyW":
      case "KeyA":
      case "KeyS":
      case "KeyD":
        return ["H", "K"];
      case "ArrowUp":
      case "ArrowLeft":
      case "ArrowDown":
      case "ArrowRight":
        return ["B", "E"];
      default:
        return [];
    }
  }
}
