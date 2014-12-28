'use strict'

describe 'Service: Recursionhelper', ->

  # load the service's module
  beforeEach module 'kvetchApp'

  # instantiate service
  Recursionhelper = {}
  beforeEach inject (_Recursionhelper_) ->
    Recursionhelper = _Recursionhelper_

  it 'should do something', ->
    expect(!!Recursionhelper).toBe true
