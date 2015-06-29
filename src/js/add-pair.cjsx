React = require 'react'
jQuery = require 'jquery'

module.exports = React.createClass

	onSubmit: (ev) ->
		ev.preventDefault()
		map = {}
		nameEls = [].slice.call ev.target.querySelectorAll '[name]'
		nameEls.forEach (el) -> map[el.name] = el.value
		app.socket.emit 'data',
			endpoint: '/pairs/insert'
			value: map
		app.hideModal()
		return

	render: ->
		<div className="add-pair">
			<div className="heading">Přidat sloupec</div>
			<form className="form-horizontal center" onSubmit={@onSubmit} method="POST">
				<div className="form-group">
					<label htmlFor="team1-name" className="col-xs-5 control-label">Tým 1</label>
					<div className="col-xs-2"></div>
					<label htmlFor="team2-name" className="col-xs-5 control-label">Tým 2</label>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="text" className="form-control" id="team1-name" name="team1Name" placeholder="Boston" />
					</div>
					<label htmlFor="team1-name" className="col-xs-2 control-label">jméno</label>
					<div className="col-xs-5">
						<input type="text" className="form-control" id="team2-name" name="team2Name" placeholder="Philadelphia" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="text" className="form-control" id="team1-abbr" name="team1Abbr" placeholder="BOS"  />
					</div>
					<label htmlFor="team1-abbr" className="col-xs-2 control-label">zkratka</label>
					<div className="col-xs-5">
						<input type="text" className="form-control" id="team2-abbr" name="team2Abbr" placeholder="PHI" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-12 center">
						<button type="submit" className="btn btn-primary">Přidat</button>
						<button type="button" className="btn btn-default" onClick={app.hideModal}>Zrušit</button>
					</div>
				</div>
			</form>
		</div>
