// ---------------------------------------------------------------------------//
// APP ROUTER
// ---------------------------------------------------------------------------//
// The APP router sets up all the endpoints for the web app.
// ---------------------------------------------------------------------------//
// Dependencies
var express         = require('express');
var path            = require('path');
var router          = express.Router();

module.exports = function(app, passport) {

  router.get('/confirm/:token', function(req, res) {
    console.log(req.params.token);

    var nodemailer = require('nodemailer');
    var transporter = nodemailer.createTransport(app.config.smtpConfig);
    transporter.sendMail({
        from: 'noreply@windoapp.com',
        to: 'jdeanwaite@gmail.com',
        subject: 'Confirm registration',
        text: 'hello world!'
    }, function(result) {
      console.log(result);
      res.send('jo');
    });
  });

  router.get('/*', function(req, res) {
    res.set( { 'content-type': 'text/html; charset=utf-8' } )
       .sendFile(path.join(__dirname, '../../client', 'index.html'));
  });

// The result of this module will be the router.
  return router;
};
