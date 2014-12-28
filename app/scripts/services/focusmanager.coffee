angular.module('kvetchApp')
  .service 'FocusManager', ($rootScope) ->
    scope = $rootScope.$new(true)

    return {
      focused: null
      events: scope
      set: (element) ->
        @focused = element
        scope.$emit 'focus', element
    }
