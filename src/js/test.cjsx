React = require 'react'
MatchColumn = require './match-column'

module.exports = React.createClass

	getInitialState: ->
		matchStore: []

	componentDidMount: ->
		app.matchStore.on 'all', @onModelChange

	componentWillUnmount: ->
		app.matchStore.off 'all', @onModelChange

	onModelChange: ->
		@setState matchStore: app.matchStore.toJSON()

	render: ->
		matchStore1 = @state.matchStore
		matchStore2 = @state.matchStore
		matchStore3 = @state.matchStore

		columnCount = 3
		columnClass = 'col-xs-' + Math.floor 12 / columnCount
		<div className="row">
			<MatchColumn key="col-1" columnClass={columnClass} matchStore={matchStore1} pics={['philadelphia', 'boston']} />
			<MatchColumn key="col-2" columnClass={columnClass} matchStore={matchStore2} pics={['boston', 'montreal']} />
			<MatchColumn key="col-3" columnClass={columnClass} matchStore={matchStore3} pics={['montreal', 'philadelphia']} />
		</div>
		
