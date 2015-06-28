var MatchColumn, React;

React = require('react');

MatchColumn = require('./match-column');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      matchStore: []
    };
  },
  componentDidMount: function() {
    return app.matchStore.on('all', this.onModelChange);
  },
  componentWillUnmount: function() {
    return app.matchStore.off('all', this.onModelChange);
  },
  onModelChange: function() {
    return this.setState({
      matchStore: app.matchStore.toJSON()
    });
  },
  render: function() {
    var columnClass, columnCount, matchStore1, matchStore2, matchStore3;
    matchStore1 = this.state.matchStore;
    matchStore2 = this.state.matchStore;
    matchStore3 = this.state.matchStore;
    columnCount = 3;
    columnClass = 'col-xs-' + Math.floor(12 / columnCount);
    return React.createElement("div", {
      "className": "row"
    }, React.createElement(MatchColumn, {
      "key": "col-1",
      "columnClass": columnClass,
      "matchStore": matchStore1,
      "pics": ['philadelphia', 'boston']
    }), React.createElement(MatchColumn, {
      "key": "col-2",
      "columnClass": columnClass,
      "matchStore": matchStore2,
      "pics": ['boston', 'montreal']
    }), React.createElement(MatchColumn, {
      "key": "col-3",
      "columnClass": columnClass,
      "matchStore": matchStore3,
      "pics": ['montreal', 'philadelphia']
    }));
  }
});
