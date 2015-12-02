actions = require '../actions/matches'

initialState =
	isFetching: no
	didInvalidate: no
	items: []

matches = (state = initialState, action) ->

	switch action.type
		when actions.INVALIDATE_MATCHES
			Object.assign({}, state, 
				didInvalidate: yes
			)

		when actions.REQUEST_MATCHES
			Object.assign({}, state,
				isFetching: yes
				didInvalidate: no
			)

		when actions.RECEIVE_MATCHES
			Object.assign({}, state,
				isFetching: no
				didInvalidate: no
				items: action.matches
				lastUpdated: action.receivedAt
			)

		else state

module.exports = matches