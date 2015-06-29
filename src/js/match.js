var React;

React = require('react');

module.exports = React.createClass({
  render: function() {
    return React.createElement("div", {
      "className": "match"
    }, React.createElement("div", {
      "className": "row"
    }, React.createElement("div", {
      "className": "row col-xs-6"
    }, React.createElement("div", {
      "className": "row"
    }, "\t\t\t\t\t\tV\u00edt\u011bz"), React.createElement("div", {
      "className": "row"
    }, React.createElement("img", {
      "src": './src/assets/' + this.props.winPic + '.svg',
      "width": "100%"
    }))), React.createElement("div", {
      "className": "row col-xs-6"
    }, React.createElement("table", {
      "className": "table table-striped"
    }, React.createElement("thead", null, React.createElement("tr", null, React.createElement("th", null), React.createElement("th", null, "BOS"), React.createElement("th", null, "PHI"))), React.createElement("tbody", null, React.createElement("tr", null, React.createElement("td", null, "G\u00f3ly"), React.createElement("td", null, this.props.team1Score), React.createElement("td", null, this.props.team2Score)), React.createElement("tr", null, React.createElement("td", null, "St\u0159ely"), React.createElement("td", null, this.props.team1Shots), React.createElement("td", null, this.props.team2Shots)), React.createElement("tr", null, React.createElement("td", null, "Vhazov\u00e1n\u00ed"), React.createElement("td", null, this.props.team1Faceoffs), React.createElement("td", null, this.props.team2Faceoffs)))))));
  }
});
