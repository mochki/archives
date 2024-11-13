import React, { Component } from "react";
import { Link } from "react-router-dom";
import Slider from "react-slick";
import { ImagesFin } from "../../helpers/LoadedCheck";
import "./project.scss";

import leftArrow from "./left-arrow.png";
import rightArrow from "./right-arrow.png";

const settings = {
  autoplay: true,
  autoplaySpeed: 5000,
  arrows: false,
};

export default class Project extends Component {
  constructor(props) {
    super(props);

    this.state = {
      loading: true,
    };
    this.desktopSlider = null;
    this.mobileSlider = null;
  }

  _checkLoad = () => {
    if (ImagesFin()) {
      this.setState({
        loading: false,
      });
    }
  };

  render() {
    const { name, description, images, mobileImages, nextProject, carousel } =
      this.props;
    const { loading } = this.state;
    window.scrollTo(0, 0);
    return (
      <div className="project-component">
        <div className={`loading ${loading ? "" : "loading-done"}`}></div>
        {carousel && (
          <div className={`slider-desktop ${loading ? "" : "show"}`}>
            <div className="arrow-left-wrapper">
              <div
                className="arrow-left"
                onClick={() =>
                  this.desktopSlider && this.desktopSlider.slickPrev()
                }
              >
                <img src={leftArrow} alt="" />
              </div>
            </div>
            <div className="arrow-right-wrapper">
              <div
                className="arrow-right"
                onClick={() =>
                  this.desktopSlider && this.desktopSlider.slickNext()
                }
              >
                <img src={rightArrow} alt="" />
              </div>
            </div>
            <Slider
              {...settings}
              fade={true}
              draggable={false}
              ref={(dS) => {
                this.desktopSlider = dS;
              }}
            >
              {images.map((img, idx) => (
                <div key={idx}>
                  <img src={img} alt="" onLoad={this._checkLoad} />
                </div>
              ))}
            </Slider>
          </div>
        )}
        {carousel && (
          <div className={`slider-mobile ${loading ? "" : "show"}`}>
            <div className="arrow-right-wrapper">
              <div
                className="arrow-right"
                onClick={() =>
                  this.mobileSlider && this.mobileSlider.slickNext()
                }
              >
                <img src={rightArrow} alt="" />
              </div>
            </div>
            <Slider
              {...settings}
              ref={(mS) => {
                this.mobileSlider = mS;
              }}
            >
              {mobileImages.map((img, idx) => (
                <div key={idx}>
                  <img src={img} alt="" onLoad={this._checkLoad} />
                </div>
              ))}
            </Slider>
          </div>
        )}
        {!carousel && (
          <div className={`grid ${loading ? "" : "show"}`}>
            {images.map((img, idx) => (
              <div className="image-wrapper" key={idx}>
                <img src={img} alt="" onLoad={this._checkLoad} />
              </div>
            ))}
          </div>
        )}
        <div className={`title ${loading ? "" : "show"}`}>{name}</div>
        <div className={`row ${loading ? "" : "show"}`}>
          <div className="description">{description}</div>
          <div className="next">
            <Link to={`/${nextProject}`}>NEXT PROJECT</Link>
          </div>
        </div>
      </div>
    );
  }
}
