angular.module('windoApp').directive('submitTimes', function () {
  return {
    restrict: 'E',
    templateUrl: '/meetup/submit.html',
    controllerAs: 'submitTimes',
    controller: function ($state, $http, $stateParams) {
      var vm = this;

      $http.get('/api/v0/meetups/' + $stateParams.id)
      .then(function(res) {
        console.log('meetup', res);
        vm.meetup = res.data;
        vm.startDay = new Date(vm.meetup.dateHash[0].unixTime * 1000);
        var lastDay = new Date(vm.meetup.dateHash[vm.meetup.dateHash.length - 1].unixTime
                               * 1000);
        if (vm.startDay != lastDay)
          vm.lastDay = lastDay;
      })
      .catch(function(err) {
        console.log('no fun:', err);
      })
    }
  }
});
