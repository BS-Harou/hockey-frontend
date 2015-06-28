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
    this.props.hideAddForm();
  },
  render: function() {
    return React.createElement("div", {
      "className": "add-pair"
    }, React.createElement("form", {
      "className": "form-horizontal",
      "onSubmit": this.onSubmit,
      "method": "POST"
    }, React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "number",
      "className": "form-control",
      "id": "team1-score",
      "name": "team1Score",
      "defaultValue": "0",
      "dir": "RTL"
    })), React.createElement("label", {
      "htmlFor": "team1-score",
      "className": "col-xs-2 control-label"
    }, "g\u00f3l\u016f"), React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "number",
      "className": "form-control",
      "id": "team2-score",
      "name": "team2Score",
      "defaultValue": "0"
    }))), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "number",
      "className": "form-control",
      "id": "team1-shots",
      "name": "team1Shots",
      "defaultValue": "0",
      "dir": "RTL"
    })), React.createElement("label", {
      "htmlFor": "team1-shots",
      "className": "col-xs-2 control-label"
    }, "st\u0159el"), React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "number",
      "className": "form-control",
      "id": "team2-shots",
      "name": "team2Shots",
      "defaultValue": "0"
    }))), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-12 center"
    }, React.createElement("select", {
      "className": "form-control",
      "id": "win-type",
      "name": "winType"
    }, React.createElement("option", {
      "value": "regular"
    }, "V b\u011b\u017en\u00e9 hrac\u00ed dob\u011b"), React.createElement("option", {
      "value": "ot"
    }, "V prodlou\u017een\u00ed"), React.createElement("option", {
      "value": "so"
    }, "V n\u00e1jezdech")))), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-12 center"
    }, React.createElement("button", {
      "type": "submit",
      "className": "btn btn-primary"
    }, "P\u0159idat"), React.createElement("button", {
      "type": "button",
      "className": "btn btn-default",
      "onClick": this.props.hideAddForm
    }, "Zru\u0161it")))));
  }
});