actions = require '../actions/teams'

initialState =
	isFetching: no
	didInvalidate: no
	items: []

teams = (state = initialState, action) ->

	switch action.type
		when actions.INVALIDATE_TEAMS
			Object.assign({}, state, 
				didInvalidate: yes
			)

		when actions.REQUEST_TEAMS
			Object.assign({}, state,
				isFetching: yes
				didInvalidate: no
			)

		when actions.RECEIVE_TEAMS
			Object.assign({}, state,
				isFetching: no
				didInvalidate: no
				items: action.teams
				lastUpdated: action.receivedAt
			)

		else state

module.exports = teams