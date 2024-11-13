import React from "react";
import { Link } from "react-router-dom";
import download from "../../assets/icons/download.png";
import ux from "../../assets/icons/ux.png";
import "./about.scss";

export default function About(props) {
  window.scrollTo(0, 0);
  return (
    <div className="about-component">
      <div className="intro">
        <p>
          I am a Japanese-American visual and interaction designer. Currently I
          am obsessed with bike rides, laying on the ground and looking up at
          trees, eating chicken wings and well dressed men. I also love
          laughing.
        </p>
        <p>
          I am currently a designer for Project Happiness, a non-profit in
          Cupertino, CA. I received a BFA in Graphic Design from Brigham Young
          University.
        </p>
      </div>
      <div className="links-wrapper">
        <a href="#">
          <div className="download link">
            <div className="icon-wrapper">
              <img src={download} alt="" />
            </div>
            <div className="link-text">DOWNLOAD RESUME</div>
          </div>
        </a>
        <Link to="/ux">
          <div className="ux link">
            <div className="icon-wrapper">
              <img src={ux} alt="" />
            </div>
            <div className="link-text">VIEW UX PORTFOLIO</div>
          </div>
        </Link>
      </div>
      <div className="bar"></div>
      <div className="section">
        <div className="title">Contact</div>
        <div className="contact row">
          <div className="email">
            <a href="mailto:___@gmail.com">___@gmail.com</a>
          </div>
          <div className="phone">
            <a href="tel:+1-123-456-7890">123.456.7890</a>
          </div>
        </div>
      </div>
      <div className="bar"></div>
      <div className="section">
        <div className="title">Experience</div>
        <div className="experience row">
          <div className="cp">
            <div className="company">Project Happiness</div>
            <div className="position">Web & Graphic Designer</div>
          </div>
          <div className="location">Cupertino, CA</div>
          <div className="time">-</div>
        </div>
        <div className="experience row">
          <div className="cp">
            <div className="company">Vivint Solar</div>
            <div className="position">UX Designer</div>
          </div>
          <div className="location">Lehi, UT</div>
          <div className="time">-</div>
        </div>
        <div className="experience row">
          <div className="cp">
            <div className="company">Punchcut</div>
            <div className="position">Interactive Design Intern</div>
          </div>
          <div className="location">San Fransisco, CA</div>
          <div className="time">-</div>
        </div>
        <div className="experience row">
          <div className="cp">
            <div className="company">Bridger</div>
            <div className="position">UX Design Intern</div>
          </div>
          <div className="location">New York, NY</div>
          <div className="time">-</div>
        </div>
        <div className="experience row">
          <div className="cp">
            <div className="company">Nu Skin Global Marketing</div>
            <div className="position">Graphic Designer</div>
          </div>
          <div className="location">Provo, UT</div>
          <div className="time">-</div>
        </div>
        <div className="experience row">
          <div className="cp">
            <div className="company">BYU</div>
            <div className="position">Web & Graphic Designer</div>
          </div>
          <div className="location">Provo, UT</div>
          <div className="time">-</div>
        </div>
      </div>
      <div className="bar"></div>
      <div className="section">
        <div className="title">Education</div>
        <div className="education row">
          <div className="sp">
            <div className="school">Brigham Young University</div>
            <div className="program">BFA of Graphic Design</div>
          </div>
          <div className="location">Provo, UT</div>
        </div>
        <div className="education row">
          <div className="sp">
            <div className="school">University of the Arts London, CSM</div>
            <div className="program">Information Design Short Course</div>
          </div>
          <div className="location">London, UK</div>
        </div>
      </div>
      <div className="bar"></div>
      <div className="section">
        <div className="title">Skills</div>
        <div className="skill row">Adobe Creative Suite</div>
        <div className="skill row">Sketch & Invision</div>
        <div className="skill row">User Experience & Research</div>
        <div className="skill row">Responsive Design</div>
        <div className="skill row bottom">Basic HTML & CSS</div>
      </div>
    </div>
  );
}
