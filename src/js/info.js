var React;

React = require('react');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      detail: false
    };
  },
  onClick: function() {
    return this.setState({
      detail: !this.state.detail
    });
  },
  removePair: function() {
    var ref;
    if (!confirm('Určitě chcete odstranit tento sloupec?')) {
      return;
    }
    if (!((ref = this.props.pair) != null ? ref._id : void 0)) {
      return;
    }
    app.socket.emit('data', {
      endpoint: '/pairs/remove',
      value: {
        '_id': this.props.pair._id
      }
    });
  },
  render: function() {
    var detail, ref, ref1, team1, team1Img, team2, team2Img;
    team1 = ((ref = app.teamStore.get(this.props.pair.team1)) != null ? ref.toJSON() : void 0) || {};
    team2 = ((ref1 = app.teamStore.get(this.props.pair.team2)) != null ? ref1.toJSON() : void 0) || {};
    team1Img = team1.icon ? React.createElement("img", {
      "src": './src/assets/' + team1.icon,
      "height": "40"
    }) : null;
    team2Img = team2.icon ? React.createElement("img", {
      "src": './src/assets/' + team2.icon,
      "height": "40"
    }) : null;
    if (this.state.detail) {
      detail = React.createElement("div", {
        "className": "row"
      }, React.createElement("button", {
        "type": "button",
        "className": "btn btn-danger btn-xs",
        "onClick": this.removePair
      }, "Remove"));
    }
    return React.createElement("div", {
      "className": 'info',
      "onClick": this.onClick
    }, React.createElement("div", {
      "className": "row unselectable"
    }, React.createElement("div", {
      "className": "text-left col-xs-5"
    }, team1Img, team1.abbr), React.createElement("div", {
      "className": "text-center col-xs-2"
    }, "\t\t\t\t\tvs"), React.createElement("div", {
      "className": "text-right  col-xs-5"
    }, team2.abbr, team2Img)), detail);
  }
});
