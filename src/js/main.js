var AddPair, Backbone, MatchStore, PairStore, React, Test, addPairButton, app, io, main, modalPlaceholder, socket;

Backbone = require('backbone');

React = require('react');

io = require('socket.io-client');

window.app = app = new Backbone.Model;

Test = require('./test');

MatchStore = require('./match-store');

PairStore = require('./pair-store');

AddPair = require('./add-pair');

app.pairStore = new PairStore;

app.matchStore = new MatchStore;

app.socket = socket = io('ws://localhost:3000');

socket.on('connect', function() {
  console.log('Socket.io: connected to server');
  return app.trigger('start');
});

socket.on('data', function(msg) {
  if ((msg != null ? msg.endpoint : void 0) === '/matches/list') {
    app.matchStore.reset(JSON.parse(msg.value));
  }
  if ((msg != null ? msg.endpoint : void 0) === '/pairs/list') {
    return app.pairStore.reset(JSON.parse(msg.value));
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

app.hideModal = function() {
  return React.unmountComponentAtNode(modalPlaceholder);
};
