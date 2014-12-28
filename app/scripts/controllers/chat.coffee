angular.module("kvetchApp").controller "ChatCtrl", ($scope, $firebase, $timeout) ->
  alert = (msg) ->
    $scope.err = msg

    $timeout ->
      $scope.err = null
    , 5000

  ref = new Firebase('https://kvetch.firebaseio.com/')
  rootRef = ref.child('messages/-JeET71Lq_8X116CKmTs')

  $scope.rootMessage = rootMessage = $firebase(rootRef).$asObject()

  $scope.newMessage = {}

  $scope.addMessage = ->
    return unless $scope.newMessage.text

    $scope.newMessage.createdAt = new Date

    $scope.newMessage.parent = rootMessage.id
    rootMessage.children ?= []
    rootMessage.children.push $scope.newMessage.id
    rootMessage.$save()

    $scope.messages.$add($scope.newMessage).then null, alert

    $scope.newMessage = {}

  $scope.handleKeydown = (event) ->
    if event.keyCode is 13 and not event.shiftKey
      event.preventDefault()
      $scope.addMessage()
