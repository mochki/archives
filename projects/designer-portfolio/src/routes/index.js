import React from "react";
import { BrowserRouter as Router, Route, Routes as R } from "react-router-dom";
import "./routes.scss";
import Seed from "../assets/seed";

import Header from "../components/Header";
import Footer from "../components/Footer";
import Home from "./Home";
import Project from "../components/Project";
import UX from "./UX";
import About from "./About";

export default function Routes() {
  const projectRoutes = Seed.map(
    ({ name, description, images, mobileImages, carousel = true }, idx) => (
      <Route
        path={`/${name}`}
        key={idx}
        element={
          <Project
            name={name}
            description={description}
            images={images}
            mobileImages={mobileImages}
            nextProject={Seed[idx + 1] ? Seed[idx + 1].name : Seed[0].name}
            carousel={carousel}
          />
        }
      />
    )
  );

  return (
    <Router>
      <div className="site-container">
        <Header />
        <div className="routes-container">
          <R>
            <Route path="/" element={<Home />} />
            {projectRoutes}
            <Route path="/ux" element={<UX />} />
            <Route path="/about" element={<About />} />
          </R>
        </div>
        <Footer />
      </div>
    </Router>
  );
}
