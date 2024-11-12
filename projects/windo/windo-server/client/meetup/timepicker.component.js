angular.module('windoApp').directive('timePicker', function () {
  return {
    restrict: 'E',
    templateUrl: '/meetup/timepicker.html',
    controllerAs: 'timePicker',
    scope: {
      dateHash: '=dateHash'
    },
    controller: function ($state, $http, $scope) {
      var vm = this;

      vm.days = {};
      vm.selectedHours = {};
      vm.limitTimes = $scope.limitTimes;

      $scope.$watch('dateHash', function() {
        vm.dateHash = $scope.dateHash;
        //var hours = {};
        console.log('dateHash:', $scope.dateHash);
        if (vm.dateHash)
          for (var day in vm.dateHash) {
            var unixTime = vm.dateHash[day].unixTime;
            if (!vm.days[unixTime])
              vm.days[unixTime] = {};
            vm.days[unixTime].date = new Date(unixTime * 1000);
            vm.days[unixTime].unixTime = unixTime;

            //if (Object.keys(vm.selectedDays[unixTime]).length > 0 && limitTimes != false)
            //  vm.days[unixTime].hours = vm.selectedDays.dateHash[unixTime];
            // else
            vm.days[unixTime].hours = {};
            for (var i = 6; i < 24; i++)
              vm.days[unixTime].hours[i] = 0;
          }

        //vm.hours = hours;
        // console.log("hey it chagnes");
        console.log(vm.days);
      });

      vm.selectHour = function(day, hour) {
        vm.days[day.unixTime].hours[hour]++;

        if (vm.days[day.unixTime].hours[hour] > 1)
          vm.days[day.unixTime].hours[hour] = 0;

        for (var index in vm.dateHash) {
          if (vm.dateHash[index].unixTime == day.unixTime) {
            var submission;
            var i = 0;
            for (i = 0; i < vm.dateHash[index].submissions.length; i++) {
              if (vm.dateHash[index].submissions[i]._userId == "1234") {
                submission = vm.dateHash[index].submissions[i];
                break;
              }
            }

            if (submission) {
              if (vm.days[day.unixTime].hours[hour] == 1)
                submission.hours[hour] = 1;
              else
                delete submission.hours[hour];

              vm.dateHash[index].submissions[i] = submission;
              console.log('updated ', submission);
            } else {
              submission = {
                _userId: "1234",
                hours: {}
              };
              submission.hours[hour] = 1;
              vm.dateHash[index].submissions.push(submission);
              console.log('pushed ', submission);
            }
          }
        }
        console.log(vm.dateHash);
      };
    }
  }
});
