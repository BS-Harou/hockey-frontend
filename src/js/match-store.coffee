Backbone = require 'backbone'

class MatchModel extends Backbone.Model
	idAttribute: '_id'


class MatchCollection extends Backbone.Collection
	model: MatchModel



	initialize: ->
		@listenToOnce app, 'start', @onAppStart

	onAppStart: ->
		app.socket.emit 'data', { endpoint: '/matches/list' }

	comparator: (a) ->
		###return -1 if parseInt(a.date, 10) > parseInt(b.date, 10)
		return 1
		###
		-parseInt(a.get('date'), 10)


module.exports = MatchCollection