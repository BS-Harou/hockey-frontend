Backbone = require 'backbone'

class TeamModel extends Backbone.Model
	idAttribute: '_id'

class TeamCollection extends Backbone.Collection
	model: TeamModel

	initialize: ->
		@listenToOnce app, 'start', @onAppStart

	onAppStart: ->
		app.socket.emit 'data', { endpoint: '/teams/list' }

	comparator: (a, b) ->
		return 1 if a._id > b._id
		return -1

module.exports = TeamCollection