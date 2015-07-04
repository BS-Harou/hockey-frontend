var React, jQuery;

React = require('react');

jQuery = require('jquery');

module.exports = React.createClass({
  onSubmit: function(ev) {
    var map, nameEls;
    ev.preventDefault();
    map = {};
    nameEls = [].slice.call(ev.target.querySelectorAll('[name]'));
    nameEls.forEach(function(el) {
      return map[el.name] = el.value;
    });
    app.socket.emit('data', {
      endpoint: '/pairs/insert',
      value: map
    });
    app.hideModal();
  },
  render: function() {
    var teamOptions;
    teamOptions = app.teamStore.toJSON().map(function(team) {
      return React.createElement("option", {
        "value": team._id,
        "key": team._id
      }, team.name, " ", team.team);
    });
    return React.createElement("div", {
      "className": "add-pair"
    }, React.createElement("div", {
      "className": "heading"
    }, "P\u0159idat sloupec"), React.createElement("form", {
      "className": "form-horizontal center",
      "onSubmit": this.onSubmit,
      "method": "POST"
    }, React.createElement("div", {
      "className": "form-group"
    }, React.createElement("label", {
      "htmlFor": "team1",
      "className": "col-xs-6 control-label"
    }, "T\u00fdm 1"), React.createElement("label", {
      "htmlFor": "team2",
      "className": "col-xs-6 control-label"
    }, "T\u00fdm 2")), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-6"
    }, React.createElement("select", {
      "className": "form-control",
      "id": "team1",
      "name": "team1"
    }, teamOptions)), React.createElement("div", {
      "className": "col-xs-6"
    }, React.createElement("select", {
      "className": "form-control",
      "id": "team2",
      "name": "team2"
    }, teamOptions))), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-12 center"
    }, React.createElement("button", {
      "type": "submit",
      "className": "btn btn-primary"
    }, "P\u0159idat"), React.createElement("button", {
      "type": "button",
      "className": "btn btn-default",
      "onClick": app.hideModal
    }, "Zru\u0161it")))));
  }
});
