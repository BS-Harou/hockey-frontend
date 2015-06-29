var MatchColumn, React;

React = require('react');

MatchColumn = require('./match-column');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      matchStore: [],
      pairStore: []
    };
  },
  componentDidMount: function() {
    app.matchStore.on('all', this.onModelChange);
    return app.pairStore.on('all', this.onModelChange);
  },
  componentWillUnmount: function() {
    app.matchStore.off('all', this.onModelChange);
    return app.pairStore.off('all', this.onModelChange);
  },
  onModelChange: function() {
    return this.setState({
      matchStore: app.matchStore.toJSON(),
      pairStore: app.pairStore.toJSON()
    });
  },
  render: function() {
    var columnClass, columnCount, columns;
    columnCount = Math.max(2, this.state.pairStore.length);
    columnClass = 'col-xs-' + Math.floor(12 / columnCount);
    columns = this.state.pairStore.map((function(_this) {
      return function(pair, i) {
        var matches, pic1, pic2, ref, ref1;
        pic1 = (ref = pair.team1Name) != null ? ref.toLowerCase() : void 0;
        pic2 = (ref1 = pair.team2Name) != null ? ref1.toLowerCase() : void 0;
        matches = _this.state.matchStore.filter(function(match) {
          return match.pairId === pair._id;
        });
        return React.createElement(MatchColumn, {
          "key": pair._id,
          "pair": pair,
          "columnClass": columnClass,
          "matchStore": matches,
          "pics": [pic1, pic2]
        });
      };
    })(this));
    return React.createElement("div", {
      "className": "row"
    }, columns);
  }
});
