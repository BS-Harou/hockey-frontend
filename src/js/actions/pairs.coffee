# import * as types from '../constants/ActionTypes'

types = 
	INVALIDATE_PAIRS: 'invalidate-pairs'
	REQUEST_PAIRS: 'request-pairs'
	RECEIVE_PAIRS: 'receive-pairs'

actions =
	
	invalidatePairs: ->
		type: types.INVALIDATE_PAIRS
	
	requestPairs: ->
		type: types.REQUEST_PAIRS
	  
	receivePairs: (pairs) ->
		type: types.RECEIVE_PAIRS
		pairs: pairs
		receivedAt: Date.now()

Object.assign actions, types

module.exports = actions