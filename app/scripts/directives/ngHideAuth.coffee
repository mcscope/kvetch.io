angular.module('kvetchApp')
.directive 'ngHideAuth', ($timeout, $firebaseAuth) ->

  ref = new Firebase('https://kvetch.firebaseio.com/messages/')
  auth = $firebaseAuth(ref)

  return {
    restrict: "A"
    link: (scope, el) ->
      # hide until we process it
      update = ->

        loggedIn = !!auth.$getAuth()
        # sometimes if ngCloak exists on same element, they argue, so make sure that
        # this one always runs last for reliability
        $timeout (->
          el.toggleClass "ng-cloak", not !loggedIn
        ), 0

      el.addClass "ng-cloak"
      update()
      auth.$onAuth update
  }
