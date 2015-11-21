React = require 'react'
Match = require './match'
AddButton = require './add-button'
AddMatch = require './add-match'
Info = require './info'

css = require '../css/match-column.styl'

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

		series = []
		seriesIndex = 0

		matchStore.forEach (match, i) =>
			series[seriesIndex] = [] unless Array.isArray series[seriesIndex]

			team1Wins++ if parseInt(match.team1Score, 10) > parseInt(match.team2Score, 10)
			team2Wins++ if parseInt(match.team2Score, 10) > parseInt(match.team1Score, 10)
			serieWon = no
			if team1Wins > 3 or team2Wins > 3
				serieWon = yes

			series[seriesIndex].push <Match key={match._id} pair={@props.pair} {...match} />

			if serieWon
				series[seriesIndex].winningTeam = if team1Wins > 3 then @props.pair.team1 else @props.pair.team2
				team1Wins = team2Wins = 0
				series[seriesIndex].reverse()
				seriesIndex++
			else if i is matchStore.length - 1
				series[seriesIndex].reverse()

		series.reverse()

		matches = series.map (serie, i) ->
			winningTeam = app.teamStore.get(serie.winningTeam)?.toJSON()
			head = <img src={'./src/assets/' + winningTeam?.icon} height="48px"  /> if winningTeam
			head = '?' unless winningTeam
			<div key={'serie' + i} className={css['serie'] + ' row'}>
				<div className={css['serie-head'] + ' unselectable row'}>
					{head}
				</div>
				<div className={css['serie-top'] + ' row'}>
					<table className={css['top-table']}>
						<tbody>
							<tr>
								<td className="unselectable">Vítěz</td>
								<td className="unselectable">Skóre</td>
							</tr>
						</tbody>
					</table>
				</div>
				{serie}
			</div>

		addButton = <AddButton clickHandler={@showAddForm} />
		addMatch = <AddMatch pair={@props.pair} hideAddForm={@hideAddForm} />

		addComponent = if @state.showAddForm then addMatch else addButton

		<div className={@props.columnClass + ' match-column'}>
			<Info pair={@props.pair} pics={@props.pics} />
			{addComponent}
			{matches}
		</div>
