angular.module('windoApp').directive('login', function () {
  return {
    restrict: 'E',
    templateUrl: '/login/login.html',
    controllerAs: 'login',
    controller: function (authService, $http, $state) {
      var vm = this;

      vm.register = function() {
        if (vm.password != vm.confirmPassword) {
          vm.confirmPassword = "";
          return;
        }

        if (vm.registerForm.$valid) {
          var user = {
            firstName: vm.firstname,
            lastName: vm.lastname,
            email: vm.email,
            password: vm.password
          };

          console.log('submitting a valid form!', user);
          $http.post("/api/v0/users/", user).success(function(data, status) {
              console.log(data);
              console.log(status);
          });
        }
      }

      vm.login = function() {
        if (vm.loginForm.$valid) {
          console.log('loggin in');

          authService.login(vm.username, vm.loginPassword)
          .then(function (user) {
            if (user) {
              $state.go('dashboard');
            } else {
              vm.username = "";
              vm.loginPassword = "";
            }
          })
        }
      }

    }
  }
});
