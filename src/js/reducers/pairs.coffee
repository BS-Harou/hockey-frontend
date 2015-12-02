actions = require '../actions/pairs'

initialState =
	isFetching: no
	didInvalidate: no
	items: []

getId = (maxId, todo) ->
	Math.max(todo.id, maxId)

pairs = (state = initialState, action) ->

	switch action.type
		when actions.INVALIDATE_PAIRS
			Object.assign({}, state, 
				didInvalidate: yes
			)

		when actions.REQUEST_PAIRS
			Object.assign({}, state,
				isFetching: yes
				didInvalidate: no
			)

		when actions.RECEIVE_PAIRS
			Object.assign({}, state,
				isFetching: no
				didInvalidate: no
				items: action.pairs
				lastUpdated: action.receivedAt
			)

		else state

module.exports = pairs