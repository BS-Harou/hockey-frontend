var AddPair, Backbone, MatchStore, React, Test, addPairButton, app, io, main, modalPlaceholder, socket;

Backbone = require('backbone');

React = require('react');

io = require('socket.io-client');

window.app = app = new Backbone.Model;

Test = require('./test');

MatchStore = require('./match-store');

AddPair = require('./add-pair');

app.matchStore = new MatchStore;

app.socket = socket = io('ws://localhost:3000');

socket.on('connect', function() {
  console.log('Socket.io: connected to server');
  return app.trigger('start');
});

socket.on('data', function(msg) {
  if ((msg != null ? msg.endpoint : void 0) === '/matches/list') {
    return app.matchStore.add(JSON.parse(msg.value));
  }
});

main = document.querySelector('#content');

if (!main) {
  throw new Error('No main element');
}

React.render(React.createElement(Test), main);

modalPlaceholder = document.getElementById('custom-modal');

addPairButton = document.getElementById('add-pair-button');

addPairButton.addEventListener('click', function() {
  return React.render(React.createElement(AddPair), modalPlaceholder);
});
