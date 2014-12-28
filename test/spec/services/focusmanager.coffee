'use strict'

describe 'Service: Focusmanager', ->

  # load the service's module
  beforeEach module 'kvetchApp'

  # instantiate service
  Focusmanager = {}
  beforeEach inject (_Focusmanager_) ->
    Focusmanager = _Focusmanager_

  it 'should do something', ->
    expect(!!Focusmanager).toBe true
