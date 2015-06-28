React = require 'react'

module.exports = React.createClass
	render: ->
		<div className="match">
			{@props.teamA?.name} {@props.team1Score} : {@props.team2Score}	{@props.teamB?.name}
		</div>
