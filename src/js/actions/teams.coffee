types = 
	INVALIDATE_TEAMS: 'invalidate-teams'
	REQUEST_TEAMS: 'request-teams'
	RECEIVE_TEAMS: 'receive-teams'

actions =
	
	invalidateTeams: ->
		type: types.INVALIDATE_TEAMS
	
	requestTeams: ->
		type: types.REQUEST_TEAMS
	  
	receiveTeams: (teams) ->
		type: types.RECEIVE_TEAMS
		teams: teams
		receivedAt: Date.now()

Object.assign actions, types

module.exports = actions