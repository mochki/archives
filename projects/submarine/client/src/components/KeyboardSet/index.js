import React from "react";
import "./keyboard-set.css";
import KeyboardButton from "../KeyboardButton";

import up from "../../assets/icons/up.png";
import left from "../../assets/icons/left.png";
import down from "../../assets/icons/down.png";
import right from "../../assets/icons/right.png";

export default function KeyboardSet(props) {
  // Some of these will be undefined
  const { KeyW, KeyA, KeyS, KeyD } = props.states;
  const { ArrowUp, ArrowLeft, ArrowDown, ArrowRight } = props.states;
  return (
    <div
      className={`keyboard-set-component${
        props.className ? ` ${props.className}` : ""
      }`}
    >
      <KeyboardButton
        className={`set-button top${KeyW || ArrowUp ? " active" : ""}`}
      >
        {!props.arrows ? "W" : <img src={up} alt="" />}
      </KeyboardButton>
      <KeyboardButton
        className={`set-button left${KeyA || ArrowLeft ? " active" : ""}`}
      >
        {!props.arrows ? "A" : <img src={left} alt="" />}
      </KeyboardButton>
      <KeyboardButton
        className={`set-button bottom${KeyS || ArrowDown ? " active" : ""}`}
      >
        {!props.arrows ? "S" : <img src={down} alt="" />}
      </KeyboardButton>
      <KeyboardButton
        className={`set-button right${KeyD || ArrowRight ? " active" : ""}`}
      >
        {!props.arrows ? "D" : <img src={right} alt="" />}
      </KeyboardButton>
    </div>
  );
}
