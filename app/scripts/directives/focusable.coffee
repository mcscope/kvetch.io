angular.module('kvetchApp')
  .directive 'focusable', (FocusManager) ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.on 'click', (e) ->
        e.stopPropagation()

        FocusManager.set element

      FocusManager.events.$on 'focus', (e, newVal) ->
        if newVal is element
          element.addClass 'focused'
        else
          element.removeClass 'focused'

      if not FocusManager.focused?
        FocusManager.set element
