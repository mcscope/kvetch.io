'use strict'

describe 'Directive: focusable', ->

  # load the directive's module
  beforeEach module 'kvetchApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<focusable></focusable>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the focusable directive'
