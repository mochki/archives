// Declares the initial angular module "windoApp". Module grabs other
// controllers and services.
var app = angular.module('windoApp', [
  'ui.router',
  'ngMaterial',
  'ngMessages',
]);

angular.module('windoApp').config(function ($mdThemingProvider) {
  $mdThemingProvider.theme('default')
    .primaryPalette('orange', {
      'hue-2': '700'
    })
    .accentPalette('light-blue')
    .warnPalette('red');

  $mdThemingProvider.theme('teal')
    .primaryPalette('teal')
    .accentPalette('pink')
    .warnPalette('deep-orange');

  $mdThemingProvider.theme('pink')
      .primaryPalette('pink', {
        'hue-2': '700'
      })
      .accentPalette('indigo')
      .warnPalette('indigo');

  $mdThemingProvider.theme('purple')
      .primaryPalette('deep-purple', {
        'hue-2': '600'
      })
      .accentPalette('pink')
      .warnPalette('pink');

});

angular.module('windoApp').controller(function($scope) {
  console.log('hi');
})
