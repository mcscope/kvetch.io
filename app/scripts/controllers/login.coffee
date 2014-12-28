"use strict"

###
@ngdoc function
@name kvetchApp.controller:LoginCtrl
@description
# LoginCtrl
Manages authentication to any active providers.
###
angular.module("kvetchApp").controller "LoginCtrl", ($scope, $firebaseAuth, $location) ->

  ref = new Firebase('https://kvetch.firebaseio.com/messages/')
  auth = $firebaseAuth(ref)

  login = (provider, opts) ->
    $scope.err = null

    auth.$authWithOAuthPopup(provider).catch (err) ->
      console.log err
      $scope.err = err
    .then (authData) ->
      console.log(authData)

  $scope.oauthlogin = (provider) ->
    login provider

    return

  return
