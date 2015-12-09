React = require 'react'
ReactDOM = require 'react-dom'
MatchColumn = require './match-column'
PureRenderMixin = require 'react-addons-pure-render-mixin'
AddPair = require './add-pair'

css = require '../css/columns.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'Columns'

	openAddPair: ->
		ReactDOM.render React.createElement(AddPair, app.store.getState()), app.modalPlaceholder
		return

	render: ->
		columnClass = css['column']
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

		<div className={css['columns']}>
			{columns}

			<div className={css['add-column']} onClick={@openAddPair}>+</div>
		</div>


