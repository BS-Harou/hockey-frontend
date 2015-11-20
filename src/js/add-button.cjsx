React = require 'react'

css = require '../css/add-button.styl'

module.exports = React.createClass
	render: ->
		<div className={css['add-button']} onClick={@props.clickHandler} >
			+
		</div>
