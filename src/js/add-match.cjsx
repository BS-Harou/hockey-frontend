React = require 'react'
jQuery = require 'jquery'
PureRenderMixin = require 'react-addons-pure-render-mixin'

css = require '../css/add-match.styl'

module.exports = React.createClass
	mixins: [PureRenderMixin]

	displayName: 'AddMatch'

	validate: (map) ->
		if map['team1Score'] + map['team2Score'] <= 0
			return 'Musel padnout alespon jeden gol'

		if map['team1Score'] is map['team2Score']
			return 'Hra nemuze skoncit remizou'

		if map['team1Shots'] < map['team1Score'] or map['team2Shots'] < map['team2Score']
			return 'Tym nemuze mit vice golu nez strel'

		if map['team1Faceoffs'] + map['team2Faceoffs'] <= 0
			return 'Ve hre muselo byt alespon jedno vhazovani'

	onSubmit: (ev) ->
		ev.preventDefault()
		map =
			pairId: @props.pair._id
		nameEls = [].slice.call ev.target.querySelectorAll '[name]'
		nameEls.forEach (el) -> 
			val = if el.type is 'number' then parseFloat(el.value) else el.value
			map[el.name] = val

		if error = @validate map
			alert 'Chyba: ' + error
			return
			
		app.socket.emit 'data',
			endpoint: '/matches/insert'
			value: map
		@props.hideAddForm()
		return

	render: ->
		# TODO - doma/venku
		<div className={css['add-match']}>
			<form className="form-horizontal" onSubmit={@onSubmit} method="POST">
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-score" name="team1Score" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-score" className="col-xs-2 control-label">
						<span className={css['overflow-center']}>gólů</span>
					</label>
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team2-score" name="team2Score" defaultValue="0" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5 text-right">
						<input type="radio" id="team1-home" name="teamHome" value="1" defaultChecked="checked" />
					</div>
					<label htmlFor="team1-home" className="col-xs-2 control-label">
						<span className={css['overflow-center']}>doma</span>
					</label>
					<div className="col-xs-5">
						<input type="radio" id="team2-home" name="teamHome" value="2" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-shots" name="team1Shots" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-shots" className="col-xs-2 control-label">
						<span className={css['overflow-center']}>střel</span>
					</label>
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team2-shots" name="team2Shots" defaultValue="0" />
					</div>
				</div>
				<div className="form-group">
					<div className="col-xs-5">
						<input type="number" className="form-control" id="team1-faceoffs" name="team1Faceoffs" defaultValue="0" dir="RTL" />
					</div>
					<label htmlFor="team1-shots" className="col-xs-2 control-label">
						<span className={css['overflow-center']}>vhazování</span>
					</label>
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
