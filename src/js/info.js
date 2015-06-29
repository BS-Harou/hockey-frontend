var React;

React = require('react');

module.exports = React.createClass({
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
    return React.createElement("div", {
      "className": 'info'
    }, React.createElement("div", {
      "className": "row"
    }, React.createElement("div", {
      "className": "text-left col-xs-5"
    }, React.createElement("img", {
      "src": './src/assets/' + this.props.pics[0] + '.svg',
      "height": "40"
    }), this.props.pair.team1Abbr), React.createElement("div", {
      "className": "text-center col-xs-2"
    }, "\t\t\t\t\tvs"), React.createElement("div", {
      "className": "text-right  col-xs-5"
    }, this.props.pair.team2Abbr, React.createElement("img", {
      "src": './src/assets/' + this.props.pics[1] + '.svg',
      "height": "40"
    }))), React.createElement("div", {
      "className": "row"
    }, React.createElement("button", {
      "type": "button",
      "className": "btn btn-danger btn-xs",
      "onClick": this.removePair
    }, "x")));
  }
});
