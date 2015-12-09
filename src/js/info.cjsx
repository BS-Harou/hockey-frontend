React = require 'react'
ReactDOM = require 'react-dom'
Stats = require './stats'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/info.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'Info'

	getInitialState: ->
		detail: no

	onClick: ->
		@setState
			detail: not @state.detail

	removePair: ->
		return unless confirm 'Určitě chcete odstranit tento sloupec?'
		return unless @props.pair?._id
		app.socket.emit 'data',
			endpoint: '/pairs/remove'
			value: '_id': @props.pair._id
		return

	showStats: ->
		ReactDOM.render React.createElement(Stats, 
			pair: @props.pair
			teams: @props.teams
			matches: @props.matches
		), app.modalPlaceholder
		return

	getTeam: (id) ->
		for team in @props.teams.items
			return team if team['_id'] is id
		return null

	render: ->
		team1 = @getTeam(@props.pair.team1) or {}
		team2 = @getTeam(@props.pair.team2) or {}
		team1Img = if team1.icon then <img src={'./src/assets/' + team1.icon} height="40" /> else null
		team2Img = if team2.icon then <img src={'./src/assets/' + team2.icon} height="40" /> else null

		if @state.detail
			detail =
				<div className="row">
					<button type="button" className="btn btn-danger btn-xs" onClick={@removePair}>Odstranit</button>
					<button type="button" className="btn btn-primary btn-xs" onClick={@showStats}>Statistiky</button>
				</div>

		<div className={css.info} onClick={@onClick}>
			<div className="row unselectable">
				<div className="text-left col-xs-5">
					{team1Img} 
					{team1.abbr}
				</div>
				<div className="text-center col-xs-2">
					vs
				</div>
				<div className="text-right  col-xs-5">
					{team2.abbr}
					{team2Img}
				</div>	
			</div> 
			{detail}
		</div>
