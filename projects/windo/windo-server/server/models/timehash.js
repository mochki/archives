// ---------------------------------------------------------------------------//
// MEET-UPS MODEL
// ---------------------------------------------------------------------------//
// This module contains the Meet-ups model. The Meet-ups model is comprised of
//  - _ownerId:   The user id of who created the meetup.
//  - name:       The name of the event.
//  - created_at: The date and time the user was created.
//  - updated_at: The date and time of the last update.
//  - fromDate:   The start date of the event time bounds.
//  - toDate:     The end date of the event time bounds.
//  - invitees:   Array of user ids which are invited to the meetup.
// ---------------------------------------------------------------------------//
// Dependencies
var mongoose          = require('mongoose');
var Schema            = mongoose.Schema;

// Creates a Meetup Schema. This will be the basis of how meetup data is stored.
var MeetupSchema = new Schema({
    _ownerId:   { type: String, required: true                  },
    name:       { type: Schema.Types.ObjectId, required: true   },
    created_at: { type: Date, default: Date.now                 },
    updated_at: { type: Date, default: Date.now                 },
    fromDate:   { type: Date, required: true                    },
    toDate:     { type: Date, required: true                    },
    invitees:   { type: [Schema.Types.ObjectId]                 }
});

// Sets the created_at parameter equal to the current time
MeetupSchema.pre('save', function(next){
    now = new Date();
    this.updated_at = now;
    if(!this.created_at) {
        this.created_at = now
    }
    next();
});

// Exports the UserSchema. Sets the MongoDB collection to be used as: "Users"
module.exports = mongoose.model('Meetup', UserSchema);
