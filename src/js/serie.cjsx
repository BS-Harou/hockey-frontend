React = require 'react'
Match = require './match'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/serie.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'Serie'

	getTeam: (id) ->
		for team in @props.teams.items
			return team if team['_id'] is id
		return null

	render: ->
		matches = @props.matches.map (match) =>
			<Match key={match._id} pair={@props.pair} teams={@props.teams} {...match} />
			
		winningTeam = @getTeam @props.winningTeamId
		head = <img src={'./src/assets/' + winningTeam?.icon} height="48px"  /> if winningTeam
		head = '?' unless winningTeam
		<div className={css['serie'] + ' row'}>
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
			{matches}
		</div>
	