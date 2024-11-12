angular.module('windoApp').directive('eventLanding', function () {
  return {
    restrict: 'E',
    templateUrl: '/meetup/event.html',
    controllerAs: 'eventLanding',
    controller: function ($state, $http, $stateParams) {
      var vm = this;
      console.log('workgin', $stateParams.id);

      vm.dateTime = "";
      vm.location = "";

      $http.get('/api/v0/meetups/' + $stateParams.id)
      .then(function(res) {
        console.log('meetup', res);
        vm.meetup = res.data;
        console.log(vm.meetup);

        if (vm.meetup.finalized) {
          // todo: when a time has been picked, display it!
          vm.dateTime = "Finalized!"
        } else
          vm.dateTime = "TBD";

        console.log('modified', vm.meetup);
        vm.hasSubmitted = hasSubmitted(vm.meetup);

        vm.location = vm.meetup.location || "Not Specified";
      })
      .catch(function(err) {
        console.log('no fun:', err);
      });

      function hasSubmitted(meetup) {
        for (var day in meetup.dateHash) {
          for (var submission in meetup.dateHash[day].submissions) {
            if (meetup.dateHash[day].submissions[submission]._userId == 1234) {
              return true;
            }
          }
        }

        return false;
      }
    }
  }
});
