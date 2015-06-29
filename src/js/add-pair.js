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
      "htmlFor": "team1-name",
      "className": "col-xs-5 control-label"
    }, "T\u00fdm 1"), React.createElement("div", {
      "className": "col-xs-2"
    }), React.createElement("label", {
      "htmlFor": "team2-name",
      "className": "col-xs-5 control-label"
    }, "T\u00fdm 2")), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "text",
      "className": "form-control",
      "id": "team1-name",
      "name": "team1Name",
      "placeholder": "Boston"
    })), React.createElement("label", {
      "htmlFor": "team1-name",
      "className": "col-xs-2 control-label"
    }, "jm\u00e9no"), React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "text",
      "className": "form-control",
      "id": "team2-name",
      "name": "team2Name",
      "placeholder": "Philadelphia"
    }))), React.createElement("div", {
      "className": "form-group"
    }, React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "text",
      "className": "form-control",
      "id": "team1-abbr",
      "name": "team1Abbr",
      "placeholder": "BOS"
    })), React.createElement("label", {
      "htmlFor": "team1-abbr",
      "className": "col-xs-2 control-label"
    }, "zkratka"), React.createElement("div", {
      "className": "col-xs-5"
    }, React.createElement("input", {
      "type": "text",
      "className": "form-control",
      "id": "team2-abbr",
      "name": "team2Abbr",
      "placeholder": "PHI"
    }))), React.createElement("div", {
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
