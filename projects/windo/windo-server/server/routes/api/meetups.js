// ---------------------------------------------------------------------------//
// MEETUP API IMPLEMENTATIONS
// ---------------------------------------------------------------------------//
// This file contains the implementations for the Meetup endpoints of the API
// router.
// ---------------------------------------------------------------------------//
// Dependencies
var mongoose         = require('mongoose');
var Meetup           = require('../../models').Meetup;

module.exports = {
  getAll: getAll,
  getOne: getOne,
  insert: insert,
  update: update,
  remove: remove
};

// ---------------------------------------------------------------------------//
// Meetups: Get all
// Retrieves a list of all the meetups and sends them to the client.
// TODO:
// - get Meetup info from session and return list of all meetups
// - figure out default max number of meetups to return.
// - allow for query of max number to return or base on dates.
// ---------------------------------------------------------------------------//
function getAll (req, res) {
  console.log('retrieving all meetups');
  Meetup.find({}, function(err, docs) {
    if (err) {
      res.status(400);
      return res.send(err);
    }

    res.status(200);
    res.json(docs);
  });
}

// ---------------------------------------------------------------------------//
// Meetups: Get one
// Retrieves a list of all the meetups and sends them to the client.
// TODO:
// - get Meetup info from session and return list of all meetups
// - figure out default max number of meetups to return.
// - allow for query of max number to return or base on dates.
// ---------------------------------------------------------------------------//
function getOne (req, res) {
  console.log('retrieving a meetups');
  Meetup.findOne({ _id: req.params.id }, function(err, doc) {
    if (err) {
      res.status(400);
      return res.send(err);
    }

    if (!doc) {
      res.status(404);
      return res.json({});
    }

    res.status(200);
    res.json(doc);
  });
}

// ---------------------------------------------------------------------------//
// Meetups: Insert
// Inserts a new meetup into the database. Sends the new doc, or err if exists.
// ---------------------------------------------------------------------------//
function insert (req, res) {
  console.log('saving new meetup: ', req.body);

  if (!req.body.dateHash || Object.keys(req.body.dateHash) <= 0)
    return res.status(400).json({
      error : "A date hash is required"
    });

  //var validated = false;
  // TODO: Validate.
  //for (var unixTime in req.body.dateHash) {
  //  validate = true;
  //  var date = new Date(unixTime * 1000);
  //  console.log(unixTime + ", " + date);
  //  if (date == "Invalid Date")
  //    return res.status(400).json({
  //      error : "The given dates are invalid"
  //    });
  //
  //  var today = new Date(Date.now());
  //  var month = date.getMonth();
  //  var year  = date.getFullYear();
  //  var day   = date.getDate();
  //  if (month > 11 || month < 0 || day > 31 || day < 0 ||
  //      year < today.getFullYear() || year > (today.getFullYear() + 5))
  //    return res.status(400).json({
  //      error : "The given dates are out of range"
  //    });
  //}

  // Attach the owner id
  req.body._ownerId = req.user._id;

  // Create the meetup object using the Meetup Schema.
  var newMeetup = new Meetup(req.body);

  newMeetup.save(function(err, meetupDoc) {
    console.log('done', meetupDoc);
    if (err) {
      res.status(400);
      return res.send(err);
    }

    res.status(200);
    res.json(meetupDoc);
  });
}

// ---------------------------------------------------------------------------//
// Meetups: Update
// Updates the given meetup document. If the meetup is not found then it returns
// a 404, if it is successful then it returns a 200 and sends the new meetup
// document to the client.
// TODO:
// - who can update this? Make sure that if they arent the creator that
//   they cant maliciously update the meetup.
// -
// ---------------------------------------------------------------------------//
function update (req, res) {
  console.log('updating meetup ' + req.params.id + 'with:', req.body);
  Meetup.findOne({ _id: req.params.id }, function(err, doc) {
    if (err) {
      res.status(400);
      return res.send(err);
    }

    if (!doc) {
      res.status(404);
      return res.send('Meetup not found');
    }

    doc.name     = req.body.name;
    doc.fromDate = req.body.fromDate;
    doc.toDate   = req.body.toDate;
    doc.invitees = req.body.invitees;
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
}

// ---------------------------------------------------------------------------//
// Meetups: Remove
// Removes a meetup from the database. Returns err if one exists.
// ---------------------------------------------------------------------------//
function remove (req, res) {
  console.log('removing meetup: ', req.params.id);
  Meetup.findOneAndRemove({ _id: req.params.id }, function (err, doc) {
    if (err) {
      res.status(400);
      return res.send(err);
    }
    if (!doc) {
      res.status(404);
      return res.send("meetup not found");
    }
    res.status(200);
    res.send('success');
  });
}
