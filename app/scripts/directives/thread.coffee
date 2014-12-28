angular.module('kvetchApp')
  .directive 'thread', (RecursionHelper) ->
    templateUrl: 'views/thread.html'
    restrict: 'E'
    scope:
      root: '='
      depth: '@'
    link: (scope, element, attrs) ->
      scope.depth = +scope.depth
      if isNaN scope.depth
        scope.depth = 0

    compile: (element) ->
      return RecursionHelper.compile(element)
