angular.module("kvetchApp").controller "ChatCtrl", ($scope, fbutil, $timeout) ->
  alert = (msg) ->
    $scope.err = msg

    $timeout ->
      $scope.err = null
    , 5000

  # synchronize a read-only, synchronized array of messages, limit to most recent 10
  $scope.messages = fbutil.syncArray("messages", limit: 10)

  # display any errors
  $scope.messages.$loaded().then null, alert

  $scope.newMessage = {}

  $scope.addMessage = ->
    return unless $scope.newMessage.text

    $scope.newMessage.createdAt = new Date

    $scope.messages.$add($scope.newMessage).then null, alert

    $scope.newMessage = {}
