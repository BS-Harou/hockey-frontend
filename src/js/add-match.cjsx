React = require 'react'
jQuery = require 'jquery'

module.exports = React.createClass

	onSubmit: (ev) ->
		ev.preventDefault()
		map = {}
		nameEls = [].slice.call ev.target.querySelectorAll '[name]'
		nameEls.forEach (el) -> map[el.name] = el.value
		app.socket.emit 'data',
			endpoint: '/matches/insert'
			value: map
		@props.hideAddForm()
		return

	render: ->
		# TODO - doma/venku
		<div className="add-match">
			<form className="form-horizontal" onSubmit={@onSubmit} method="POST">
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-score" name="team1Score" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-score" className="col-xs-2 control-label">gólů</label>
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team2-score" name="team2Score" defaultValue="0" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-shots" name="team1Shots" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-shots" className="col-xs-2 control-label">střel</label>
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team2-shots" name="team2Shots" defaultValue="0" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-faceoffs" name="team1Faceoffs" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-shots" className="col-xs-2 control-label">vhazování</label>
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team2-faceoffs" name="team2Faceoffs" defaultValue="0" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-12 center">
						<select className="form-control" id="win-type" name="winType">
							<option value="regular">V běžné hrací době</option>
							<option value="ot">V prodloužení</option>
							<option value="so">V nájezdech</option>
						</select>
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-12 center">
						<button type="submit" className="btn btn-primary">Přidat</button>
						<button type="button" className="btn btn-default" onClick={@props.hideAddForm}>Zrušit</button>
					</div>
				</div>
			</form>
		</div>
