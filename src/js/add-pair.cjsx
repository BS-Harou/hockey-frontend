React = require 'react'
jQuery = require 'jquery'

css = require '../css/add-pair.styl'

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

		teamOptions = app.teamStore.toJSON().map (team) ->
			<option value={team._id} key={team._id}>{team.name} {team.team}</option>

		<div className={css['add-pair']}>
			<div className="heading">Přidat sloupec</div>
			<form className="form-horizontal center" onSubmit={@onSubmit} method="POST">
				<div className="form-group">
					<label htmlFor="team1" className="col-xs-6 control-label">Tým 1</label>
					<label htmlFor="team2" className="col-xs-6 control-label">Tým 2</label>
				</div>

				<div className="form-group">
					<div className="col-xs-6">
						<select className="form-control" id="team1" name="team1">
							{teamOptions}
						</select>
					</div>
					<div className="col-xs-6">
						<select className="form-control" id="team2" name="team2">
							{teamOptions}
						</select>
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
