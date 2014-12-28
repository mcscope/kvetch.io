"use strict"
angular.module("kvetchApp").filter "reverse", ->
  (items) ->
    if angular.isArray(items) then items.slice().reverse() else []