Backbone = require 'backbone'

class PairModel extends Backbone.Model
	idAttribute: '_id'

class PairCollection extends Backbone.Collection
	model: PairModel

	initialize: ->
		@listenToOnce app, 'start', @onAppStart

	onAppStart: ->
		app.socket.emit 'data', { endpoint: '/pairs/list' }

	comparator: (a, b) ->
		return 1 if a.date > b.date
		return -1

module.exports = PairCollection