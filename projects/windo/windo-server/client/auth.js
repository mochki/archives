angular.module('windoApp').factory('authService',
  function ($q, $timeout, $http) {

    console.log('mm');

    // create user variable
    var user = null;

    // return available functions for use in controllers
    return ({
      // Querys the server to check if the user is logged in.
      isLoggedIn: function () {
        return $http.get('/login/status')
        .then(function(res) {
          console.log('status:', res.status);
          console.log('data:', res.data);
          return (res.data) ? true : false;
        }).catch(function(err) {
          console.log('err:', err);
          return false;
        });
      },

      login: function (username, password) {
        var creds = {
          username: username,
          password: password
        };

        return $http.post("/login", creds)
        .then(function(res) {
          console.log(res.data);
          console.log(res.status);
          return res.data;
        })
        .catch(function(err) {
          console.log('login failed:', err);
          return false;
        });
      },
      logout: false,
      register: false,
      user: function () { console.log('returning'); return user; }
    });
});
