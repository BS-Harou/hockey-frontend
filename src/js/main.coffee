Backbone = require 'backbone'
React = require 'react'
ReactDOM = require 'react-dom'
io = require 'socket.io-client'
Highcharts = require 'highcharts-browserify'

window.app = app = new Backbone.Model

require '../css/main.styl'

Columns = require './columns'
MatchStore = require './match-store'
PairStore = require './pair-store'
TeamStore = require './team-store'
AddPair = require './add-pair'
app.pairStore = new PairStore
app.matchStore = new MatchStore
app.teamStore = new TeamStore


#
# Sockets
#

app.socket = {}

app.socket = socket = io 'ws://localhost:3000'
socket.on 'connect', ->
	console.log 'Socket.io: connected to server'
	app.trigger 'start'


socket.on 'data', (msg) ->
	if msg?.endpoint is '/matches/list'
		app.matchStore.reset JSON.parse msg.value
		app.matchStore.sort()
		up()
	if msg?.endpoint is '/pairs/list'
		app.pairStore.reset JSON.parse msg.value
		app.pairStore.sort()
		up()
	if msg?.endpoint is '/teams/list'
		app.teamStore.reset JSON.parse msg.value
		app.teamStore.sort()
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
		ReactDOM.render React.createElement(Columns), main



#
# Nav
#
app.modalPlaceholder = modalPlaceholder = document.getElementById 'custom-modal'
addPairButton = document.getElementById 'add-pair-button'
addPairButton.addEventListener 'click', ->
	ReactDOM.render React.createElement(AddPair), modalPlaceholder
	return

app.hideModal = ->
	React.unmountComponentAtNode modalPlaceholder
	return

document.addEventListener 'click', (ev) ->
	if ev.target.id is 'custom-modal'
		app.hideModal()