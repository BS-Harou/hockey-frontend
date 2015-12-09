React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/match.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	getInitialState: ->
		detail: no

	onClick: ->
		@setState
			detail: not @state.detail

	removeMatch: ->
		return unless confirm 'Určitě chcete odstranit tento zápas?'
		return unless @props?._id
		app.socket.emit 'data',
			endpoint: '/matches/remove'
			value: '_id': @props._id
		return

	getTeam: (id) ->
		for team in @props.teams.items
			return team if team['_id'] is id
		return null

	render: ->
		team1 = @getTeam @props.pair.team1 or {}
		team2 = @getTeam @props.pair.team2 or {}

		winningTeam = if parseInt(@props.team1Score, 10) > parseInt(@props.team2Score, 10) then team1 else team2

		if not @state.detail
			return <div className={css.match} onClick={@onClick}>
					<div className="row">
						<div className="row col-xs-6">
							<div className="row text-left">
								<div className={css['image-wrapper']}>
									<img src={'./src/assets/' + winningTeam.icon} height="24px" />
								</div>
								<div className="text-wrapper">
									{winningTeam.name}
								</div>
							</div>
						</div>
						<div className="row col-xs-6">
							{team1.abbr} {parseInt @props.team1Score} : {parseInt @props.team2Score} {team2.abbr} 
						</div>
					</div>

				</div>

		<div className={css.match + ' unselectable'} onClick={@onClick} style={@props.st}>
			<div className="row">
				<div className="row col-xs-5">
					<div className="row unselectable">
						Vítěz
					</div>
					<div className={"row unselectable " + css['winning-team-icon']}>
						<img src={'./src/assets/' + winningTeam.icon} width="100%" />
					</div>
				</div>
				<div className="row col-xs-7">
					<table className="table table-striped">
						<thead>
							<tr>
								<th></th>
								<th>{team1.abbr}</th>
								<th>{team2.abbr}</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>Góly</td>
								<td>{@props.team1Score}</td>
								<td>{@props.team2Score}</td>
							</tr>
							<tr>
								<td>Střely</td>
								<td>{@props.team1Shots}</td>
								<td>{@props.team2Shots}</td>
							</tr>
							<tr>
								<td>Vhazování</td>
								<td>{@props.team1Faceoffs}</td>
								<td>{@props.team2Faceoffs}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div className="row">
				<button type="button" className="btn btn-danger btn-xs" onClick={@removeMatch}>x</button>
			</div>
		</div>

