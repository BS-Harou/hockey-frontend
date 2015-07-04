Backbone = require 'backbone'
React = require 'react'
io = require 'socket.io-client'
Chart = require 'chart.js'

window.app = app = new Backbone.Model

Test = require './test'
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
		React.render React.createElement(Test), main




#
# Nav
#
modalPlaceholder = document.getElementById 'custom-modal'
addPairButton = document.getElementById 'add-pair-button'
addPairButton.addEventListener 'click', ->
	React.render React.createElement(AddPair), modalPlaceholder
	return

#
# Highcharts
#

app.hideModal = ->
	React.unmountComponentAtNode modalPlaceholder
	return


ctx = document.getElementById("myChart").getContext("2d")

data = {
    labels: ["January", "February", "March", "April", "May", "June", "July"],
    datasets: [
        {
            label: "Team 1",
            fillColor: "rgba(220,220,220,0.2)",
            strokeColor: "rgba(220,220,220,1)",
            pointColor: "rgba(220,220,220,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(220,220,220,1)",
            data: [65, 59, 80, 81, 56, 55, 40]
        },
        {
            label: "Team 2",
            fillColor: "rgba(151,187,205,0.2)",
            strokeColor: "rgba(151,187,205,1)",
            pointColor: "rgba(151,187,205,1)",
            pointStrokeColor: "#fff",
            pointHighlightFill: "#fff",
            pointHighlightStroke: "rgba(151,187,205,1)",
            data: [28, 48, 40, 19, 86, 27, 90]
        }
    ]
}

# myLineChart = new Chart(ctx).Line data, {}

###
app.matchStore.on 'all', ->
	data.labels = app.matchStore.pluck('date').map((val) -> new Date(val))
	data.datasets[0].data = app.matchStore.pluck('team1Score').map((val) -> Number(val) or 0)
	data.datasets[1].data = app.matchStore.pluck('team2Score').map((val) -> Number(val) or 0)
	new Chart(ctx).Line data, {}
###