import React from "react";
import "./footer.scss";

export default function Footer(props) {
  return (
    <div className="footer-component">
      <div className="copyright">Designer © 2015</div>
      <div className="social">
        <a
          href="https://www.linkedin.com/#"
          target="_blank"
          rel="noopener noreferrer"
        >
          LinkedIn
        </a>
        <a
          href="https://www.instagram.com/#/"
          target="_blank"
          rel="noopener noreferrer"
        >
          Instagram
        </a>
        <a
          href="https://www.facebook.com/#"
          target="_blank"
          rel="noopener noreferrer"
        >
          Facebook
        </a>
        <a
          href="https://www.behance.net/#"
          target="_blank"
          rel="noopener noreferrer"
        >
          Behance
        </a>
      </div>
      <div className="social-mobile">
        <div className="row">
          <a
            href="https://www.linkedin.com/#"
            target="_blank"
            rel="noopener noreferrer"
          >
            LinkedIn
          </a>
          <a
            href="https://www.instagram.com/#/"
            target="_blank"
            rel="noopener noreferrer"
          >
            Instagram
          </a>
        </div>
        <div className="row">
          <a
            href="https://www.facebook.com/#"
            target="_blank"
            rel="noopener noreferrer"
          >
            Facebook
          </a>
          <a
            href="https://www.behance.net/#"
            target="_blank"
            rel="noopener noreferrer"
          >
            Behance
          </a>
        </div>
      </div>
    </div>
  );
}
