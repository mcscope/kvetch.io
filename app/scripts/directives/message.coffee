'use strict'

###*
 # @ngdoc directive
 # @name kvetchApp.directive:message
 # @description
 # # message
###
angular.module('kvetchApp')
  .directive('message', ->
    templateUrl: 'views/message.html'
    restrict: 'E'
    scope:
      message: '='
    link: (scope, element, attrs) ->
      scope.parentColorCode = (parentIDs) ->
        return unless parentIDs?.length
        id = parentIDs[0]

        return '#' + md5(id).substr(0, 6)
  )
