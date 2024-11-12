// ---------------------------------------------------------------------------//
// WINDO SERVER - app.js
// ---------------------------------------------------------------------------//
// Windo Server is the API server for the Windo App created by team FlashyFlash.
// Windo provides its users with an easy way to organize meetings by choosing
// a time for them to meet based on user availability.
// This file contains the initial MongoDB and Express setup for the Node server.
// ---------------------------------------------------------------------------//
// Dependencies
var bodyParser      = require('body-parser');
var config          = require('./config');
var cookieParser    = require('cookie-parser');
var express         = require('express');
var favicon         = require('serve-favicon');
var LocalStrategy   = require('passport-local').Strategy;
var logger          = require('morgan');
var mongoose        = require('mongoose');
var passport        = require('passport');
var path            = require('path');
var session         = require('express-session');
var RedisStore      = require('connect-redis')(session);
var app             = express();

// ---------------------------------------------------------------------------//
// Mongo and Express Setup
// ---------------------------------------------------------------------------//
// Connects to the MongoDB server
mongoose.connect("mongodb://localhost/windoServer-dev");

app.config = config;

// uncomment after placing your favicon in /public
// app.use(favicon(__dirname + '/public/favicon.ico'));

// Logging and Parsing
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

// Use for public/static elements
app.use(express.static(path.join(__dirname, '..', 'client')));
app.use(express.static(path.join(__dirname, '..', 'public')));

// Use for passport
// require('./config/passport')(passport); // pass passport for configuration
app.use(session({
  secret: config.sessionSecret,
  resave: false,
  saveUninitialized: false,
  store: new RedisStore({ // For session persistence! If we restart the server the session can still be active.
    host: 'localhost',
    port: 6379
  }),
  cookie: {
    maxAge: 3600000 * 24 * 7
  },
  rolling: true
}));

app.use(passport.initialize());
app.use(passport.session()); // persistent login sessions

// Use BowerComponents
app.use('/bower_components',  express.static(path.join(__dirname, '..', 'bower_components')));

// Passport user serialize
passport.serializeUser(function(user, done) {
  done(null, user._id);
});

// Passport user deserialize
passport.deserializeUser(function(id, done) {
  User.findById(id)
  .select('-password -created_at -updated_at -__v')
  .exec(function(err, user) {
    done(err, user);
  });
});

// Login local strategy
passport.use(new LocalStrategy(
  function(username, password, done) {
    User.findOne({ $or: [ { username: username }, { email: username }] }, function(err, user) {
      if (err) { return done(err); }
      if (!user) {
        return done(null, false, { message: 'Incorrect email/username.' });
      }
      if (!user.validPassword(password)) {
        return done(null, false, { message: 'Incorrect password.' });
      }
      return done(null, user);
    });
  }
));

// Login route
app.post('/login',
  passport.authenticate('local'),
  function (req, res) {
    User.findById(req.user._id)
    .select('-password -created_at -updated_at -__v')
    .exec(function(err, user) {
      if (!err) return res.json(user);
      res.send(null);
    });
  });

// Login status route - sends user to client
app.get('/login/status', function(req, res) {
  res.json(req.user);
});

// Logout route - logs a user out.
app.get('/logout', function(req, res) {
  req.logout();
  res.json({success: true});
});

// ---------------------------------------------------------------------------//
// Route Setup
// ---------------------------------------------------------------------------//
// Sets up the routes to be used in the server.
var apiRoutes   = require('./routes/api.routes')(app);
var appRoutes   = require('./routes/app.routes')(app);

var User = require('./models/user');

app.use('/app/'   , appRoutes  );
app.use('/api/v0/', apiRoutes  );

module.exports = app;
