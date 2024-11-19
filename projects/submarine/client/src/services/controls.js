import io from "socket.io-client";
import arraysEqual from "../helpers/arraysEqual";

const socket = io();
let lastCodes = [];

export function emitKeyEvent(codes) {
  // debounce
  if (arraysEqual(lastCodes, codes)) return;

  lastCodes = codes;

  for (const code of codes) {
    socket.emit("control input", code);
  }
}
