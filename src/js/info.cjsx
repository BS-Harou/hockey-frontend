React = require 'react'

module.exports = React.createClass
	render: ->
		<div className='info'>
			<img src={'./src/assets/' + @props.pics[0] + '.svg'} height="40" />
			&nbsp;
			BOS vs PHI
			&nbsp;
			<img src={'./src/assets/' + @props.pics[1] + '.svg'} height="40" />
		</div>
