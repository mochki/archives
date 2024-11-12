angular.module('windoApp').directive('dashboard', function () {
  return {
    restrict: 'E',
    templateUrl: '/dashboard/dashboard.html',
    controllerAs: 'dashboard',
    controller: function ($http, $state) {
      var vm = this;
      vm.meetups = [];
      vm.invitees=[];


      $http.get('/api/v0/meetups/')
      .then(function (response) {
        vm.meetups = response.data;
        console.log(vm.meetups);
      });

      vm.goToMeetup = function (id) {
        $state.go('eventLanding', {id: id});
      }

      vm.deleteMeetup = function (id) {
        $http.delete('/api/v0/meetups/' + id)
        .then(function (res) {
          console.log('yay!', res);
          // maybe check if thing there
          vm.meetups.splice(getIndex(vm.meetups, id), 1);
        })
        .catch(function(err) {
          console.log(':(', err);
        });
        // $state.go('submitTimes', {id: id});
      }
    }
  }
});

function getIndex(meetups, id) {
  for (var i = 0; i < meetups.length; i++)
    if (meetups[i]._id == id)
      return i;
}
