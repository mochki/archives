angular.module('windoApp').directive('create', function () {
  return {
    restrict: 'E',
    templateUrl: '/create/create.html',
    controllerAs: 'create',
    controller: function ($mdMedia, $mdDialog, $state, $http) {
      var vm = this;

      vm.invitees = [];
      vm.eventName = "";
      vm.location = "";
      vm.test = vm.eventName;
      vm.selectedDays = {};

      // ---------------------------------------------------------------------//
      // SUBMIT FORM
      // Inserts a new meetup into the database. Sends the new doc, or err if
      // exists.
      // ---------------------------------------------------------------------//
      vm.submitForm = function () {
        // make sure forms are valid
        if (!vm.createForm.$valid || !vm.nameForm.$valid)
          return;

        // generate the date hash object
        var dateHash = createDateHash(vm.selectedDays);

        // create the meetup object to be passed to the server
        var meetup = {
          name: vm.eventName,
          dateHash: dateHash,
          location: vm.location || ""
          // invitees: vm.invitees TODO: add invitees
        };

        console.log(meetup);

        // post the meetup to the api
        $http.post('/api/v0/meetups', meetup)
        .then(function (res) {
          console.log('success!', res);
          // redirect user to the 'select availability' page
          $state.go("submitTimes", { id: res.data._id });
        })
        .catch(function(err) {
          console.log('error', err);
        });
      };
    }
  }
});

// ---------------------------------------------------------------------------//
// CREATE DATE HASH
// Creates a date hash object out of the selected days provided by the date
// picker.
// ---------------------------------------------------------------------------//
function createDateHash(selectedDays) {
  var dateHash = [];
  for (var unixTime in selectedDays) {
    var day = {};
    day.unixTime = unixTime;
    day.availableHours = selectedDays[unixTime];
    dateHash.push(day);
  }
  return dateHash;
}

angular.module('windoApp').directive('mdChips', function () {
  return {
    restrict: 'E',
    require: 'mdChips',
    link: function (scope, element, attributes, mdChipsCtrl) {
      mdChipsCtrl.onInputBlur = function () {
        this.inputHasFocus = false;

      // ADDED CODE
        var chipBuffer = this.getChipBuffer();
        if (chipBuffer != "") { // REQUIRED, OTHERWISE YOU'D GET A BLANK CHIP
            this.appendChip(chipBuffer);
            this.resetChipBuffer();
        }
      // - EOF - ADDED CODE
      };
    }
  }
});