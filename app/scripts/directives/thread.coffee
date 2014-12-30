angular.module('kvetchApp')
  .directive 'thread', ($firebase, RecursionHelper) ->
    {
    templateUrl: 'views/thread.html'
    restrict: 'E'
    scope: {}
    link: (scope, element, attrs) ->
      scope.depth = +attrs.depth
      if isNaN scope.depth
        scope.depth = 0

      messagesRef = new Firebase('https://kvetch.firebaseio.com/messages/')
      ref = messagesRef.child("#{ attrs.rootid }")

      scope.root = root = $firebase(ref).$asObject()

    compile: (element) ->
      RecursionHelper.compile element, @link
    }
