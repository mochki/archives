angular.module('windoApp')
  .config(function ($urlRouterProvider, $stateProvider, $locationProvider, $urlMatcherFactoryProvider) {
    $urlMatcherFactoryProvider.strictMode(false);
    $locationProvider.html5Mode(true);

    $stateProvider
      // .state('login', {
      //   url: '/login',
      //   template: '<login layout="column" layout-fill></login>'
      // })
      .state('dashboard', {
        url: '/app',
        template: '<dashboard layout="column" layout-fill></dashboard>',
        resolve: { authService: authenticate }
      })
      .state('create', {
        url: '/app/create',
        template: '<create layout="column" layout-fill></create>',
        resolve: { authService: authenticate }
      })
      .state('eventLanding', {
        url: '/app/meetup/:id',
        template: '<event-landing layout="column" layout-fill></event-landing>'//,
        // resolve: { authService: authenticate }
      })
      .state('submitTimes', {
        url: '/app/meetup/:id/submit',
        template: '<submit-times layout="column" layout-fill></submit-times>'//,
        // resolve: { authService: authenticate }
      })
      .state('login', {
         url: '/app/login',
         template: '<login layout="column" layout-fill></login>'//,
         // resolve: {
         //
         // }
      })
      .state('register', {
         url: '/app/register',
         template: '<register layout="column" layout-fill></register>'//,
         // resolve: {
         //
         // }
      })
      .state('confirmation', {
         url: '/app/register/confirmation',
         template: '<confirmation layout="column" layout-fill></confirmation>'//,
         // resolve: {
         //
         // }
      });
      // .state('event', {
      //   url: '/event/:eventId',
      //   template: '<event layout="column" layout-fill></event>',
      //   resolve: {
      //     currentUser: ($q) => {
      //       if (!Meteor.userId()) {
      //         return $q.reject('AUTH_REQUIRED');
      //       }
      //       else {
      //         return $q.resolve();
      //       }
      //     }
      //   }
      // });

    $urlRouterProvider.otherwise("/app");
  });
  // .run(function ($rootScope, $state) {
  //   $rootScope.$on('$stateChangeError', function (event, toState, toParams, fromState, fromParams, error) {
  //     if (error === 'AUTH_REQUIRED') {
  //       // $state.go('login');
  //     }
  //   });
  // });

  function authenticate($q, authService, $state, $timeout) {
    return authService.isLoggedIn()
    .then(function(loggedIn) {
      console.log('is logged in:', loggedIn);
      if (loggedIn) {
        return $q.when()
      } else {
        $timeout(function() {
          // This code runs after the authentication promise has been rejected.
          // Go to the log-in page
          $state.go('login')
        });

        // Reject the authentication promise to prevent the state from loading
        return $q.reject()
      }
    });
  }
