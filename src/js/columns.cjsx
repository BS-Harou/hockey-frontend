React = require 'react'
MatchColumn = require './match-column'
PureRenderMixin = require 'react-addons-pure-render-mixin'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'Columns'

	render: ->
		columnCount = Math.max 2, @props.pairs.items.length
		xs = Math.max ( Math.floor 12 / columnCount ), 4
		columnClass = 'col-xs-' + xs
		columns = @props.pairs.items.map (pair, i) =>
			pic1 = pair.team1Name?.toLowerCase()
			pic2 = pair.team2Name?.toLowerCase()
			matches = @props.matches.items.filter (match) -> match.pairId is pair._id
			<MatchColumn
				key={pair._id}
				pair={pair}
				columnClass={columnClass}
				teams={@props.teams}
				matches={matches}
				pics={[pic1, pic2]}
			/>

		
		<div className="row">
			{columns}
		</div>
		
