React = require 'react'
Match = require './match'
AddButton = require './add-button'
AddMatch = require './add-match'
Info = require './info'

module.exports = React.createClass

	getInitialState: ->
		showAddForm: no

	showAddForm: ->
		@setState showAddForm: yes
		return

	hideAddForm: ->
		@setState showAddForm: no
		return

	onKeyDown: (e) ->
		if e.keyCode is 27 # ESC
			@setState showAddForm: no
		return

	componentDidMount: ->
		document.addEventListener 'keydown', this.onKeyDown
	

	componentWillUnmount: ->
		document.removeEventListener 'keydown', this.onKeyDown
	
	render: ->
		team1Wins = 0
		team2Wins = 0

		matchStore = @props.matchStore.slice().reverse()

		matches = matchStore.map (match) =>
			team1Wins++ if parseInt(match.team1Score, 10) > parseInt(match.team2Score, 10)
			team2Wins++ if parseInt(match.team2Score, 10) > parseInt(match.team1Score, 10)
			st = null
			st = background: 'red' if team1Wins > 3 
			st = background: 'yellow' if team2Wins > 3 
			team1Wins = team2Wins = 0 if team1Wins > 3 or team2Wins > 3

			<Match key={match._id} st={st} pair={@props.pair} {...match} />

		matches.reverse()

		addButton = <AddButton clickHandler={@showAddForm} />
		addMatch = <AddMatch pair={@props.pair} hideAddForm={@hideAddForm} />

		addComponent = if @state.showAddForm then addMatch else addButton

		<div className={@props.columnClass + ' match-column'}>
			<Info pair={@props.pair} pics={@props.pics} />
			{addComponent}
			{matches}
		</div>
