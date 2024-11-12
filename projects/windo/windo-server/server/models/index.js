// ---------------------------------------------------------------------------//
// MODELS - index.js
// ---------------------------------------------------------------------------//
// This module contains the collection of database models used in the server.
// Require this file to obtain an object containing all the models, or include
// the individual model files if only one is desired.
// ---------------------------------------------------------------------------//
// Dependencies
var meetup          = require('./meetup');
var user            = require('./user');

module.exports = {
  Meetup: meetup,
  User: user
}
