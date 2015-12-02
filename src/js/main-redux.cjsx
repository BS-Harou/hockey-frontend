React = require 'react'
ReactDOM = require 'react-dom'
io = require 'socket.io-client'
Highcharts = require 'highcharts-browserify'


window.app = app = {}

require '../css/main.styl'

AddPair = require './add-pair'

#
# Redux stuff
#
Provider = require('react-redux').Provider
Redux = require 'redux'
App = require './app'
pairActions = require './actions/pairs'
teamActions = require './actions/teams'
matchActions = require './actions/matches'

rootReducer = require './reducers'
app.store = store = Redux.createStore rootReducer, initialState = undefined

if module.hot
	module.hot.accept './reducers', ->
		nextReducer = require('./reducers')
		store.replaceReducer nextReducer

#
# Sockets
#

app.socket = {}

app.socket = socket = io 'ws://localhost:3000'
socket.on 'connect', ->
	console.log 'Socket.io: connected to server'

	store.dispatch pairActions.requestPairs()
	app.socket.emit 'data', { endpoint: '/pairs/list' }

	store.dispatch teamActions.requestTeams()
	app.socket.emit 'data', { endpoint: '/teams/list' }

	store.dispatch matchActions.requestMatches()
	app.socket.emit 'data', { endpoint: '/matches/list' }


socket.on 'data', (msg) ->
	if msg?.endpoint is '/matches/list'
		store.dispatch matchActions.receiveMatches JSON.parse msg.value
		up()
	if msg?.endpoint is '/teams/list'
		store.dispatch teamActions.receiveTeams JSON.parse msg.value
		up()
	if msg?.endpoint is '/pairs/list'
		store.dispatch pairActions.receivePairs JSON.parse msg.value
		up()

#
# React
#

upCounter = 0
up = ->
	upCounter++
	if upCounter is 3
		main = document.querySelector '#content'
		throw new Error 'No main element' unless main
		ReactDOM.render(
			<Provider store={store}>
				<App />
			</Provider>,
			main
		)



#
# Nav
#
app.modalPlaceholder = modalPlaceholder = document.getElementById 'custom-modal'
addPairButton = document.getElementById 'add-pair-button'
addPairButton.addEventListener 'click', ->
	ReactDOM.render React.createElement(AddPair, store.getState()), modalPlaceholder
	return

app.hideModal = ->
	ReactDOM.unmountComponentAtNode modalPlaceholder
	return

document.addEventListener 'click', (ev) ->
	if ev.target.id is 'custom-modal'
		app.hideModal()
