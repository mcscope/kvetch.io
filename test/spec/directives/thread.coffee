'use strict'

describe 'Directive: thread', ->

  # load the directive's module
  beforeEach module 'kvetchApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<thread></thread>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the thread directive'
