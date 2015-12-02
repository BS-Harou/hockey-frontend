React = require 'react'

css = require '../css/stats.styl'

module.exports = React.createClass

	getChart: (chartEl) ->

		team1 = @getTeam(@props.pair.team1) or {}
		team2 = @getTeam(@props.pair.team2) or {}
		selectedPairId = @props.pair._id

		matches = @props.matches

		days = matches.map (match) ->
			date = new Date match.date
			"#{date.getDate()}.#{date.getMonth() + 1}."

		sum = 0
		team1Goals = matches.map (match, i) ->
			sum += Number(match.team1Score) or 0
			Math.round(sum / (i + 1) * 10) / 10

		sum = 0
		team2Goals = matches.map (match, i) ->
			sum += Number(match.team2Score) or 0
			Math.round(sum / (i + 1) * 10) / 10

		new Highcharts.Chart
			chart:
				renderTo: 'chart-1'
			credits:
				enabled: false
			title:
				text: "Avereage #{team1.abbr} vs #{team2.abbr} Goals"
				x: -20
			xAxis:
				categories: days
			yAxis:
				title:
					text: 'Goals'
				plotLines: [
					value: 0
					width: 1
					color: '#808080'
				]
			tooltip:
				valueSuffix: ' Goals'
				shared: yes
			legend:
				layout: 'horizontal',
				align: 'center',
				verticalAlign: 'bottom',
				borderWidth: 0
			series: [
				name: team1.name
				data: team1Goals
			,
				name: team2.name
				data: team2Goals
			]

	getStats: ->
		selectedPairId = @props.pair._id
		matches = @props.matches

		team1Shots = 0
		team1Goals = 0
		team2Shots = 0
		team2Goals = 0
		team1Wins = 0
		team2Wins = 0
		matches.forEach (match) ->
			team1Shots += parseInt match.team1Shots
			team1Goals += parseInt match.team1Score
			team2Shots += parseInt match.team2Shots
			team2Goals += parseInt match.team2Score
			if parseInt(match.team1Score) >=  parseInt(match.team2Score)
				team1Wins++
			else
				team2Wins++
			return

		{
			team1Shots
			team2Shots
			team1Goals
			team2Goals
			team1SP: Math.round(team1Goals / team1Shots * 1000) / 10
			team2SP: Math.round(team2Goals / team2Shots * 1000) / 10
			team1Wins
			team2Wins
		}

	getTeam: (id) ->
		for team in @props.teams.items
			return team if team['_id'] is id
		return null

	render: ->

		team1 = @getTeam(@props.pair.team1) or {}
		team2 = @getTeam(@props.pair.team2) or {}

		setTimeout =>
			@getChart()
		, 0

		stats = @getStats()

		<div className={css.stats}>
			<div className="heading">Statistiky</div>

			<table className="table table-striped">
				<thead>
					<tr>
						<th></th>
						<th>{team1.name}</th>
						<th>{team2.name}</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>Výhry</td>
						<td>{stats.team1Wins}</td>
						<td>{stats.team2Wins}</td>
					</tr>
					<tr>
						<td>Góly</td>
						<td>{stats.team1Goals}</td>
						<td>{stats.team2Goals}</td>
					</tr>
					<tr>
						<td>Střely</td>
						<td>{stats.team1Shots}</td>
						<td>{stats.team2Shots}</td>
					</tr>
					<tr>
						<td>Úspěšnost střelby</td>
						<td>{stats.team1SP}%</td>
						<td>{stats.team2SP}%</td>
					</tr>
				</tbody>
			</table>

			<div id="chart-1" className={css.chart}></div>
		</div>
