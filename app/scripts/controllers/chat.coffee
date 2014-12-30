angular.module("kvetchApp").controller "ChatCtrl", ($scope, $routeParams, $firebase, $timeout, FocusManager) ->
  alert = (msg) ->
    $scope.err = msg

    $timeout ->
      $scope.err = null
    , 5000

  $scope.rootId = $routeParams.rootId or '-JeET71Lq_8X116CKmTs'
  messagesRef = new Firebase('https://kvetch.firebaseio.com/messages/')

  $scope.newMessage = {}

  $scope.addMessage = ->
    return unless $scope.newMessage.text

    parent = FocusManager.focused
    parentId = parent.attr('rootId')

    $scope.newMessage.createdAt = +new Date
    $scope.newMessage.parents = [parentId]

    $firebase(messagesRef).$push($scope.newMessage)
      .then (ref) ->
        $scope.newMessage.$id = ref.name()

        parentMessage = $firebase(messagesRef.child(parentId)).$asObject()
        parentMessage.$loaded().then ->
          parentMessage.children ?= []
          parentMessage.children.push $scope.newMessage.$id
          parentMessage.$save()

          $scope.newMessage = {}

      , alert

  $scope.submitIfEnter = (event) ->
    if event.keyCode is 13 and not event.shiftKey
      event.preventDefault()
      $scope.addMessage()
