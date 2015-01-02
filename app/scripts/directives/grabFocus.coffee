angular.module('kvetchApp')
  .directive 'grabFocus', (FocusManager) ->
    restrict: 'A'
    link: (scope, element, attrs) ->

      FocusManager.events.$on 'focus', ->
        element.focus()
