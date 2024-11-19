// Ensures only one key is accepted from the sets of wasd or uldr
export function enforceOnlyOneInput(code, state) {
  if (
    (code === "KeyW" ||
      code === "KeyA" ||
      code === "KeyS" ||
      code === "KeyD") &&
    (state.KeyW || state.KeyA || state.KeyS || state.KeyD)
  )
    return false;

  if (
    (code === "ArrowUp" ||
      code === "ArrowLeft" ||
      code === "ArrowDown" ||
      code === "ArrowRight") &&
    (state.ArrowUp || state.ArrowLeft || state.ArrowDown || state.ArrowRight)
  )
    return false;

  return true;
}

// Ensures we only listen to the key up even of the active key-down
export function listenToActiveOnly(code, state) {
  if (
    (code === "KeyW" && state.KeyW) ||
    (code === "KeyA" && state.KeyA) ||
    (code === "KeyS" && state.KeyS) ||
    (code === "KeyD" && state.KeyD)
  )
    return true;

  if (
    (code === "ArrowUp" && state.ArrowUp) ||
    (code === "ArrowLeft" && state.ArrowLeft) ||
    (code === "ArrowDown" && state.ArrowDown) ||
    (code === "ArrowRight" && state.ArrowRight)
  )
    return true;

  return false;
}
