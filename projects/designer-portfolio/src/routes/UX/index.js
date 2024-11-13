import React, { Component } from "react";
import sha1 from "sha1";
import { BarLoader } from "react-spinners";
import { ImagesFin } from "../../helpers/LoadedCheck";
import download from "../../assets/icons/white-download.png";
import "./ux.scss";

let checkLoadInterval;

export default class UX extends Component {
  constructor(props) {
    super(props);
    this.state = {
      password: "",
      authed: false,
      loading: true,
      imagesDone: false,
    };
  }

  hash = "3a9771731bc0c650d34114ea0d2d311bbc19cb8b";

  _handleChange = (e) => {
    this.setState(
      {
        password: e.target.value,
      },
      () => {
        if (sha1(this.state.password) === this.hash) {
          this.setState({ authed: true }, this._smoothLoadOverlay);
        }
      }
    );
  };

  _checkLoad = () => {
    if (ImagesFin()) {
      this.setState({
        imagesDone: true,
      });
    }
  };

  _smoothLoadOverlay = () => {
    setTimeout(() => {
      if (this.state.imagesDone) {
        this.setState({ loading: false });
      } else {
        checkLoadInterval = setInterval(() => {
          if (this.state.imagesDone) {
            this.setState({ loading: false }, () => {
              clearInterval(checkLoadInterval);
            });
          }
        }, 500);
      }
    }, 900);
  };

  componentDidUpdate(prevProps) {
    if (this.props.location !== prevProps.location) {
      window.scrollTo(0, 0);
    }
  }

  render() {
    return (
      <div className="ux-wrapper">
        <div className="ux-component">
          <input
            name="password"
            type="password"
            maxLength="15"
            placeholder="Enter Password"
            value={this.state.password}
            onChange={this._handleChange}
            className={this.state.authed ? "authed" : ""}
          />
        </div>
        <div className={`ux-prv-cont ${this.state.authed ? "show" : ""}`}>
          <div className="pdfHeader">
            <div className="title">UX Portfolio</div>
            <div className="download-wrapper">
              <a href="#">
                {" "}
                <img src={download} alt="" />{" "}
              </a>
            </div>
          </div>
          <div
            className={`loading ${this.state.loading ? "" : "loading-done"}`}
          >
            <BarLoader key={9000} height={3} />
          </div>
          <div className={`ux-prv-w ${this.state.loading ? "" : "show"}`}></div>
        </div>
      </div>
    );
  }
}
