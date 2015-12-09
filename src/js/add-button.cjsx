React = require 'react'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/add-button.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]
	
	render: ->
		<div className={css['add-button']} onClick={@props.clickHandler} >
			+
		</div>
