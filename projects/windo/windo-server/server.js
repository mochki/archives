#!/usr/bin/env node
// ---------------------------------------------------------------------------//
// WINDO SERVER - server.js
// ---------------------------------------------------------------------------//
// Windo Server is the API server for the Windo App created by team FlashyFlash.
// Windo provides its users with an easy way to organize meetings by choosing
// a time for them to meet based on user availability.
// This file initializes the Node.js server.
// ---------------------------------------------------------------------------//
// Dependencies
var app = require('./server/app');

// Set the port to listen on.
app.set('port', process.env.PORT || 3000);

// Start the server.
var server = app.listen(app.get('port'), function() {
    console.log('Express server listening on port ' + app.get('port'));
});
