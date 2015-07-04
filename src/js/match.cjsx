React = require 'react'

module.exports = React.createClass

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

	render: ->
		team1 = app.teamStore.get(@props.pair.team1)?.toJSON() or {}
		team2 = app.teamStore.get(@props.pair.team2)?.toJSON() or {}

		winPic = if parseInt(@props.team1Score, 10) > parseInt(@props.team2Score, 10) then team1.icon else team2.icon

		if not @state.detail
			return <div className="match" onClick={@onClick} style={@props.st}>
					<div className="row">
						<div className="row col-xs-6">
							<div className="row text-left">
								<img src={'./src/assets/' + winPic} height="24px" /> Vítěz
							</div>
						</div>
						<div className="row col-xs-6">
							{team1.abbr} {parseInt @props.team1Score} : {parseInt @props.team2Score} {team2.abbr} 
						</div>
					</div>

				</div>

		<div className="match" onClick={@onClick} style={@props.st}>
			<div className="row">
				<div className="row col-xs-6">
					<div className="row">
						Vítěz
					</div>
					<div className="row">
						<img src={'./src/assets/' + winPic} width="100%" />
					</div>
				</div>
				<div className="row col-xs-6">
					<table className="table table-striped">
						<thead>
							<tr>
								<th></th>
								<th>BOS</th>
								<th>PHI</th>
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

