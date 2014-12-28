angular.module('firebase.config', [])
  .constant('FBURL', 'https://kvetch.firebaseio.com')
  .constant('SIMPLE_LOGIN_PROVIDERS', ['password','twitter','github'])

  .constant('loginRedirectPath', '/login');