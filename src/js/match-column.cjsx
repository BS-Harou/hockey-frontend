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

	hideAddForm: ->
		@setState showAddForm: no

	onKeyDown: (e) ->
		if e.keyCode is 27 # ESC
			@setState showAddForm: no

	componentDidMount: ->
		document.addEventListener 'keydown', this.onKeyDown
	

	componentWillUnmount: ->
		document.removeEventListener 'keydown', this.onKeyDown
	
	render: ->
		matches = @props.matchStore.map (match) ->
			<Match key={match.id} {...match} />

		addButton = <AddButton clickHandler={@showAddForm} />
		addMatch = <AddMatch hideAddForm={@hideAddForm} />

		addComponent = if @state.showAddForm then addMatch else addButton

		<div className={@props.columnClass + ' match-column'}>
			<Info pics={@props.pics} />
			{addComponent}
			{matches}
		</div>
