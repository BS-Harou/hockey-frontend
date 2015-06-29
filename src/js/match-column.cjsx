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
		matches = @props.matchStore.map (match) =>
			winPic = if match.team1Score > match.team2Score then @props.pair.team1Name.toLowerCase() else @props.pair.team2Name.toLowerCase()
			<Match key={match._id} winPic={winPic} pair={@props.pair} {...match} />

		addButton = <AddButton clickHandler={@showAddForm} />
		addMatch = <AddMatch pair={@props.pair} hideAddForm={@hideAddForm} />

		addComponent = if @state.showAddForm then addMatch else addButton

		<div className={@props.columnClass + ' match-column'}>
			<Info pair={@props.pair} pics={@props.pics} />
			{addComponent}
			{matches}
		</div>
