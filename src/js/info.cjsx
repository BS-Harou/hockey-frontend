React = require 'react'

module.exports = React.createClass

	removePair: ->
		return unless confirm 'Určitě chcete odstranit tento sloupec?'
		return unless @props.pair?._id
		app.socket.emit 'data',
			endpoint: '/pairs/remove'
			value: '_id': @props.pair._id
		return

	render: ->
		<div className='info'>
			<div className="row">
				<div className="text-left col-xs-5">
					<img src={'./src/assets/' + @props.pics[0] + '.svg'} height="40" />
					{@props.pair.team1Abbr}
				</div>
				<div className="text-center col-xs-2">
					vs
				</div>
				<div className="text-right  col-xs-5">
					{@props.pair.team2Abbr}
					<img src={'./src/assets/' + @props.pics[1] + '.svg'} height="40" />
				</div>	
			</div>
			<div className="row">
				<button type="button" className="btn btn-danger btn-xs" onClick={@removePair}>x</button>
			</div>
		</div>
