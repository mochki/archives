import React from "react";
import { Link } from "react-router-dom";
import "./header.scss";

export default function Header(props) {
  return (
    <div className="header-component">
      <div className="logo-wrapper"></div>
      <div className="links">
        <Link to="/">WORK</Link>
        <Link to="/about">ABOUT</Link>
      </div>
    </div>
  );
}
