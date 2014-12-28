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
  )
