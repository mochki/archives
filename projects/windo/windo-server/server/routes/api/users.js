// ---------------------------------------------------------------------------//
// USER API IMPLEMENTATIONS
// ---------------------------------------------------------------------------//
// This file contains the implementations for the User endpoints of the API
// router.
//
// TODO:
// - Usernames
// - User email registration
// - Verfication emails
// - Passwords
// - Password changing
// - Register via FaceBook
// ---------------------------------------------------------------------------//
// Dependencies
var mongoose         = require('mongoose');
var User             = require('../../models').User;

module.exports = {

// ---------------------------------------------------------------------------//
// Users: Get all
// Retrieves a list of all the users and sends them to the client.
// ---------------------------------------------------------------------------//
  getAll: (req, res) => {
    console.log('retrieving all users');
    User.find({}, function(err, docs) {
      if (err) {
        res.status(400);
        return res.send(err);
      }

      res.status(200);
      res.json(docs);
    });
  },

// ---------------------------------------------------------------------------//
// Users: Insert
// Inserts a new user into the database. Sends the new doc, or err if exists.
// ---------------------------------------------------------------------------//
  insert: (req, res) => {
    console.log('saving new user: ', req.body);
    var newUser = new User(req.body);
    newUser.password = newUser.generateHash(newUser.password);
    console.log(newUser);

    newUser.save(function(err, userDoc) {
      console.log('done', userDoc);
      if (err) {
        res.status(400);
        console.log(err);
        return res.send(err);
      }

      res.status(200);
      res.json(userDoc);
    });
  },

// ---------------------------------------------------------------------------//
// Users: Update
// Updates the given user document. If the user is not found then it Returns
// a 404, if it is successful then it returns a 200 and sends the new user
// document to the client.
// ---------------------------------------------------------------------------//
  update: (req, res) => {
    console.log('updating user ' + req.params.id + 'with:', req.body);
    User.findOne({ _id: req.params.id }, function(err, doc) {
      if (err) {
        res.status(400);
        return res.send(err);
      }

      if (!doc) {
        res.status(404);
        return res.send('user not found');
      }

      doc.username = req.body.username;
      doc.save(function(err, newDoc) {
        if (err) {
          res.status(400);
          return res.send(err);
        }

        console.log('successfully updated:', newDoc);
        res.status(200);
        res.json(newDoc);
      })
    });
  },

// ---------------------------------------------------------------------------//
// Users: Remove
// Removes a user from the database. Returns err if one exists.
// ---------------------------------------------------------------------------//
  remove: (req, res) => {
    console.log('removing user: ', req.params.id);
    User.findOneAndRemove({ _id: req.params.id }, (err, doc) => {
      if (err) {
        res.status(400);
        return res.send(err);
      }
      if (!doc) {
        res.status(404);
        return res.send("user not found");
      }
      res.status(200);
      res.send('success');
    });
  }

}
