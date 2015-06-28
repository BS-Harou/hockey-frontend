React = require 'react'

module.exports = React.createClass

	onAddClick: ->
		alert 'kambate'

	render: ->
		<div className="add-button" onClick={@props.clickHandler} >
			+
		</div>
