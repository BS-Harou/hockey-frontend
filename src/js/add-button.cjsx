React = require 'react'

module.exports = React.createClass

	render: ->
		<div className="add-button" onClick={@props.clickHandler} >
			+
		</div>
