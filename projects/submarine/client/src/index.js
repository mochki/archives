import React, { Component } from "react";
import ReactDOM from "react-dom";
import { paintCanvas } from "./services/videoStream";
import { emitKeyEvent } from "./services/controls";
import keyEventToCode from "./helpers/keyEventToCode";
import {
  enforceOnlyOneInput,
  listenToActiveOnly,
} from "./helpers/sanitizeInputs";
import "./app.css";

import KeyboardSet from "./components/KeyboardSet";
import wasdInfo from "./assets/images/wasd-info.png";
import arrowsInfo from "./assets/images/arrows-info.png";
import infoCopy from "./assets/copy/info";

class App extends Component {
  constructor(props) {
    super(props);

    this.state = {
      init: true,
      info: false,
      KeyW: false,
      KeyA: false,
      KeyS: false,
      KeyD: false,
      ArrowUp: false,
      ArrowLeft: false,
      ArrowDown: false,
      ArrowRight: false,
    };
  }

  _handleInfoClick = () => {
    this.setState({ info: true, init: false });
  };

  _handleInfoCloseClick = () => {
    this.setState({ info: false });
  };

  _handleKeyDown = ({ code }) => {
    if (!this.state.hasOwnProperty(code)) return;
    if (!enforceOnlyOneInput(code, this.state)) return;
    emitKeyEvent(keyEventToCode(code, true));
    this.setState({ [code]: true });
  };

  _handleKeyUp = ({ code }) => {
    if (!this.state.hasOwnProperty(code)) return;
    if (!listenToActiveOnly(code, this.state)) return;
    emitKeyEvent(keyEventToCode(code, false));
    this.setState({ [code]: false });
  };

  componentWillMount() {
    document.addEventListener("keydown", this._handleKeyDown, false);
    document.addEventListener("keyup", this._handleKeyUp, false);
  }

  componentDidMount() {
    paintCanvas(this.canvas);
  }

  componentWillUnmount() {
    document.removeEventListener("keydown", this._handleKeyDown, false);
    document.removeEventListener("keyup", this._handleKeyUp, false);
  }

  render() {
    const { KeyW, KeyA, KeyS, KeyD } = this.state;
    const { ArrowUp, ArrowLeft, ArrowDown, ArrowRight } = this.state;
    const { info, init } = this.state;
    return (
      <div className="app-component">
        <canvas
          ref={(canvas) => {
            this.canvas = canvas;
          }}
          className="video-canvas"
          width="352"
          height="288"
        ></canvas>
        {!info && (
          <div className="info-button" onClick={this._handleInfoClick}>
            info
          </div>
        )}
        <KeyboardSet
          arrows={false}
          className="wasd"
          states={{ KeyW, KeyA, KeyS, KeyD }}
        />
        <KeyboardSet
          arrows={true}
          className="arrows"
          states={{ ArrowUp, ArrowLeft, ArrowDown, ArrowRight }}
        />
        <div
          className={`info-overlay${
            info ? " show fade-in" : ` ${init ? "" : "fade-out"}`
          }`}
        >
          <div
            className="info-close-button"
            onClick={this._handleInfoCloseClick}
          >
            X
          </div>
          <div className="info">
            <div className="title">Remote Controlled Submarine</div>
            {infoCopy.map((text, i) => (
              <div key={i} className="info-body">
                {text}
              </div>
            ))}
          </div>
          <img src={wasdInfo} alt="" className="wasd-info" />
          <img src={arrowsInfo} alt="" className="arrows-info" />
        </div>
      </div>
    );
  }
}

ReactDOM.render(<App />, document.getElementById("root"));
