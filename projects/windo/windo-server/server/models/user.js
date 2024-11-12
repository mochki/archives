// ---------------------------------------------------------------------------//
// USER MODEL
// ---------------------------------------------------------------------------//
// This module contains the User model. The user model is comprised of
//  - username: The user's username
//  - created_at: The date and time the user was created.
//  - updated_at: The date and time of the last update.
// ---------------------------------------------------------------------------//
// Dependencies
var bcrypt            = require('bcrypt-nodejs');
var mongoose          = require('mongoose');
var Schema            = mongoose.Schema;

// Creates a User Schema. This will be the basis of how user data is stored.
var UserSchema = new Schema({
    firstName:  {type: String, required: true },
    lastName:   {type: String, required: true },
    username:   {type: String, default: ""    },
    email:      {type: String, required: true },
    password:   {type: String, required: true },
    created_at: {type: Date, default: Date.now},
    updated_at: {type: Date, default: Date.now},
    verified:   {type: Boolean, default: false}
});

// Sets the created_at parameter equal to the current time
UserSchema.pre('save', function(next) {
    now = new Date();
    this.updated_at = now;
    if(!this.created_at) {
        this.created_at = now
    }
    next();
});

UserSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(6), null);
};

UserSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.password);
};

// Exports the UserSchema. Sets the MongoDB collection to be used as: "Users"
module.exports = mongoose.model('Users', UserSchema);
