var AddPair, Backbone, Chart, MatchStore, PairStore, React, TeamStore, Test, addPairButton, app, ctx, data, io, modalPlaceholder, socket, up, upCounter;

Backbone = require('backbone');

React = require('react');

io = require('socket.io-client');

Chart = require('chart.js');

window.app = app = new Backbone.Model;

Test = require('./test');

MatchStore = require('./match-store');

PairStore = require('./pair-store');

TeamStore = require('./team-store');

AddPair = require('./add-pair');

app.pairStore = new PairStore;

app.matchStore = new MatchStore;

app.teamStore = new TeamStore;

app.socket = socket = io('ws://localhost:3000');

socket.on('connect', function() {
  console.log('Socket.io: connected to server');
  return app.trigger('start');
});

socket.on('data', function(msg) {
  if ((msg != null ? msg.endpoint : void 0) === '/matches/list') {
    app.matchStore.reset(JSON.parse(msg.value));
    app.matchStore.sort();
    up();
  }
  if ((msg != null ? msg.endpoint : void 0) === '/pairs/list') {
    app.pairStore.reset(JSON.parse(msg.value));
    app.pairStore.sort();
    up();
  }
  if ((msg != null ? msg.endpoint : void 0) === '/teams/list') {
    app.teamStore.reset(JSON.parse(msg.value));
    app.teamStore.sort();
    return up();
  }
});

upCounter = 0;

up = function() {
  var main;
  upCounter++;
  if (upCounter === 3) {
    main = document.querySelector('#content');
    if (!main) {
      throw new Error('No main element');
    }
    return React.render(React.createElement(Test), main);
  }
};

modalPlaceholder = document.getElementById('custom-modal');

addPairButton = document.getElementById('add-pair-button');

addPairButton.addEventListener('click', function() {
  React.render(React.createElement(AddPair), modalPlaceholder);
});

app.hideModal = function() {
  React.unmountComponentAtNode(modalPlaceholder);
};

ctx = document.getElementById("myChart").getContext("2d");

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
    }, {
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
};


/*
app.matchStore.on 'all', ->
	data.labels = app.matchStore.pluck('date').map((val) -> new Date(val))
	data.datasets[0].data = app.matchStore.pluck('team1Score').map((val) -> Number(val) or 0)
	data.datasets[1].data = app.matchStore.pluck('team2Score').map((val) -> Number(val) or 0)
	new Chart(ctx).Line data, {}
 */
