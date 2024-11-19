import React from "react";
import "./keyboard-button.css";

export default function KeyboardButton(props) {
  return (
    <div
      className={`keyboard-button-component${
        props.className ? ` ${props.className}` : ""
      }`}
    >
      {props.children}
    </div>
  );
}
