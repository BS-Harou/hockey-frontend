Backbone = require 'backbone'

class MatchModel extends Backbone.Model

class MatchCollection extends Backbone.Collection
	model: MatchModel

	initialize: ->
		@listenToOnce app, 'start', @onAppStart

	onAppStart: ->
		app.socket.emit 'data', { endpoint: '/matches/list' }

	comparator: (a, b) ->
		return -1 if a.date > b.date
		return 1

module.exports = MatchCollection