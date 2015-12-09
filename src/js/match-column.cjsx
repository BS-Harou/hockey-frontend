React = require 'react'
AddButton = require './add-button'
AddMatch = require './add-match'
Info = require './info'
Serie = require './serie'
_ = require 'underscore'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/match-column.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'MatchColumn'

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

	getSortedMatches: ->
		_.sortBy @props.matches.slice(), (match) -> -match.date

	getSeries: ->
		team1Wins = 0
		team2Wins = 0

		matches = @getSortedMatches().reverse()

		series = []
		seriesIndex = 0

		matches.forEach (match, i) =>
			unless series[seriesIndex]
				series[seriesIndex] = 
					matches: []
					winningTeamId: null

			team1Wins++ if parseInt(match.team1Score, 10) > parseInt(match.team2Score, 10)
			team2Wins++ if parseInt(match.team2Score, 10) > parseInt(match.team1Score, 10)
			serieWon = no
			if team1Wins > 3 or team2Wins > 3
				serieWon = yes

			series[seriesIndex].matches.push match

			if serieWon
				series[seriesIndex].winningTeamId = if team1Wins > 3 then @props.pair.team1 else @props.pair.team2
				team1Wins = team2Wins = 0
				series[seriesIndex].matches.reverse()
				seriesIndex++
			else if i is matches.length - 1
				series[seriesIndex].matches.reverse()

		series.reverse()
		series

	render: ->
		series = @getSeries().map (serie, i) =>
			<Serie key={'serie' + i} pair={@props.pair} teams={@props.teams} {...serie} />

		addButton = <AddButton clickHandler={@showAddForm} />
		addMatch = <AddMatch pair={@props.pair} hideAddForm={@hideAddForm} />

		addComponent = if @state.showAddForm then addMatch else addButton

		<div className={@props.columnClass + ' match-column'}>
			<Info pair={@props.pair} teams={@props.teams} matches={@props.matches} pics={@props.pics} />
			{addComponent}
			{series}
		</div>
