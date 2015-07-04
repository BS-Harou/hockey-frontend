React = require 'react'
MatchColumn = require './match-column'

module.exports = React.createClass

	getInitialState: ->
		matchStore: []
		pairStore: []
		teamStore: []

	componentDidMount: ->
		@onModelChange()
		app.matchStore.on 'all', @onModelChange
		app.pairStore.on 'all', @onModelChange
		app.teamStore.on 'all', @onModelChange

	componentWillUnmount: ->
		app.matchStore.off 'all', @onModelChange
		app.pairStore.off 'all', @onModelChange
		app.teamStore.off 'all', @onModelChange

	onModelChange: ->
		@setState
			matchStore: app.matchStore.toJSON()
			pairStore: app.pairStore.toJSON()
			teamStore: app.teamStore.toJSON()

	render: ->
		columnCount = Math.max 2, @state.pairStore.length
		columnClass = 'col-xs-' + Math.floor 12 / columnCount

		columns = @state.pairStore.map (pair, i) =>
			pic1 = pair.team1Name?.toLowerCase()
			pic2 = pair.team2Name?.toLowerCase()
			matches = @state.matchStore.filter (match) -> match.pairId is pair._id
			<MatchColumn key={pair._id} pair={pair} columnClass={columnClass} matchStore={matches} pics={[pic1, pic2]} />

		
		<div className="row">
			{columns}
		</div>
		
