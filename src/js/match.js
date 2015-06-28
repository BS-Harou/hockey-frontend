var React;

React = require('react');

module.exports = React.createClass({
  render: function() {
    var ref, ref1;
    return React.createElement("div", {
      "className": "match"
    }, ((ref = this.props.teamA) != null ? ref.name : void 0), " ", this.props.team1Score, " : ", this.props.team2Score, "\t", ((ref1 = this.props.teamB) != null ? ref1.name : void 0));
  }
});
