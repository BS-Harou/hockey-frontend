React = require 'react'

module.exports = React.createClass
	render: ->
		<div className="match">
			<div className="row">
				<div className="row col-xs-6">
					<div className="row">
						Vítěz
					</div>
					<div className="row">
						<img src={'./src/assets/' + @props.winPic + '.svg'} width="100%" />
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

		</div>
