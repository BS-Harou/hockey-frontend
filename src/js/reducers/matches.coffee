actions = require '../actions/matches'
update = require 'react-addons-update'

initialState =
	isFetching: no
	didInvalidate: no
	items: []

matches = (state = initialState, action) ->

	switch action.type
		when actions.INVALIDATE_MATCHES
			update state, $merge:
				didInvalidate: yes

		when actions.REQUEST_MATCHES
			update state, $merge:
				isFetching: yes
				didInvalidate: no

		when actions.RECEIVE_MATCHES
			update state, $merge:
				isFetching: no
				didInvalidate: no
				items: action.matches
				lastUpdated: action.receivedAt

		else state

module.exports = matches