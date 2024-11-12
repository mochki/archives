angular.module('windoApp').directive('confirmation', function () {
  return {
    restrict: 'E',
    templateUrl: '/login/confirmation.html',
    controllerAs: 'confirmation',
    controller: function ($http, $scope) {
      var vm = this;
      // console.log('sdfkjsdf');

      // vm.firstname = "";
      // vm.lastname = "";

      // vm.username = "@-";

      // $scope.$watch(
      //    "register.firstname",
      //    function usernameChange(newValue, oldValue) {
      //       if (vm.username == "@" + oldValue + "-" + vm.lastname)
      //          vm.username = "@" + vm.firstname + "-" + vm.lastname;
      //    }
      // )
      //
      // $scope.$watch(
      //    "register.lastname",
      //    function usernameChange(newValue, oldValue) {
      //       if (vm.username == "@" + vm.firstname + "-" + oldValue)
      //          vm.username = "@" + vm.firstname + "-" + vm.lastname;
      //    }
      // )

    }
  }
});
