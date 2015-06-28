Backbone = require 'backbone'
React = require 'react'
io = require 'socket.io-client'

window.app = app = new Backbone.Model

Test = require './test'
MatchStore = require './match-store'
AddPair = require './add-pair'
app.matchStore = new MatchStore


#
# Sockets
#

app.socket = socket = io 'ws://localhost:3000'
socket.on 'connect', ->
	console.log 'Socket.io: connected to server'
	app.trigger 'start'

socket.on 'data', (msg) ->
	if msg?.endpoint is '/matches/list'
		app.matchStore.add JSON.parse msg.value


#
# React
#

main = document.querySelector '#content'
throw new Error 'No main element' unless main
React.render React.createElement(Test), main


#
# Nav
#
modalPlaceholder = document.getElementById 'custom-modal'
addPairButton = document.getElementById 'add-pair-button'
addPairButton.addEventListener 'click', ->
	React.render React.createElement(AddPair), modalPlaceholder