# import * as types from '../constants/ActionTypes'

types = 
	INVALIDATE_MATCHES: 'invalidate-matches'
	REQUEST_MATCHES: 'request-matches'
	RECEIVE_MATCHES: 'receive-matches'

actions =
	
	invalidateMatches: ->
		type: types.INVALIDATE_MATCHES
	
	requestMatches: ->
		type: types.REQUEST_MATCHES
	  
	receiveMatches: (matches) ->
		type: types.RECEIVE_MATCHES
		matches: matches
		receivedAt: Date.now()

Object.assign actions, types

module.exports = actions