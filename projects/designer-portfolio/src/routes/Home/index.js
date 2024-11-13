import React, { Component } from "react";
import { Link } from "react-router-dom";
import { ImagesFin } from "../../helpers/LoadedCheck";
import Seed from "../../assets/seed";
import "./home.scss";

export default class Home extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
    };
  }

  _checkLoad = () => {
    if (ImagesFin()) {
      this.setState({
        loading: false,
      });
    }
  };

  render() {
    window.scrollTo(0, 0);
    return (
      <div className="home-component-wrapper">
        <div
          className={`loading ${this.state.loading ? "" : "loading-done"}`}
        ></div>
        <div className={`home-component ${this.state.loading ? "" : "show"}`}>
          <div className="top-row">
            <div className="left">
              <Tile
                name={Seed[0].name}
                thumbnail={Seed[0].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
            <div className="right">
              <Tile
                name={Seed[1].name}
                thumbnail={Seed[1].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
          </div>
          <div className="main-row">
            <div className="left">
              <Tile
                name={Seed[4].name}
                thumbnail={Seed[4].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[6].name}
                thumbnail={Seed[6].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[5].name}
                thumbnail={Seed[5].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[8].name}
                thumbnail={Seed[8].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
            <div className="right">
              <Tile
                name={Seed[2].name}
                thumbnail={Seed[2].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[3].name}
                thumbnail={Seed[3].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[7].name}
                thumbnail={Seed[7].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[9].name}
                thumbnail={Seed[9].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
          </div>
          <div className="secondary-row">
            <div className="left">
              <Tile
                name={Seed[10].name}
                thumbnail={Seed[10].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
            <div className="right">
              <Tile
                name={Seed[11].name}
                thumbnail={Seed[11].thumbnail}
                onLoad={this._checkLoad}
              />
              <Tile
                name={Seed[12].name}
                thumbnail={Seed[12].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
          </div>
          <div className="bottom-row">
            <div className="left">
              <Tile
                name={Seed[13].name}
                thumbnail={Seed[13].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
            <div className="right">
              <Tile
                name={Seed[14].name}
                thumbnail={Seed[14].thumbnail}
                onLoad={this._checkLoad}
              />
            </div>
          </div>
        </div>
      </div>
    );
  }
}

function Tile({ name, thumbnail, onLoad }) {
  return (
    <div className="tile-component">
      <Link to={name}>
        <img src={thumbnail} alt="" onLoad={onLoad} onError={onLoad} />
        <div className="project-name">{name}</div>
      </Link>
    </div>
  );
}
