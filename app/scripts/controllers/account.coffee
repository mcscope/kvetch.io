"use strict"

###
@ngdoc function
@name muck2App.controller:AccountCtrl
@description
# AccountCtrl
Provides rudimentary account management functions.
###
angular.module("kvetchApp").controller "AccountCtrl", ($scope, user, $firebaseAuth, fbutil, $timeout) ->

  ref = new Firebase('https://kvetch.firebaseio.com/messages/')
  auth = $firebaseAuth(ref)

  error = (err) ->
    alert err, "danger"
    return
  success = (msg) ->
    alert msg, "success"
    return
  alert = (msg, type) ->
    obj =
      text: msg
      type: type

    $scope.messages.unshift obj
    $timeout (->
      $scope.messages.splice $scope.messages.indexOf(obj), 1
      return
    ), 10000
    return

  loadProfile = (user) ->
    $scope.profile.$destroy()  if $scope.profile
    fbutil.syncObject("users/" + user.uid).$bindTo $scope, "profile"
    return

  $scope.user = user
  $scope.logout = auth.$unAuth()
  $scope.messages = []
  loadProfile user

  return
