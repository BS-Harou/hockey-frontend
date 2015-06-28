var AddButton, AddMatch, Info, Match, React;

React = require('react');

Match = require('./match');

AddButton = require('./add-button');

AddMatch = require('./add-match');

Info = require('./info');

module.exports = React.createClass({
  getInitialState: function() {
    return {
      showAddForm: false
    };
  },
  showAddForm: function() {
    return this.setState({
      showAddForm: true
    });
  },
  hideAddForm: function() {
    return this.setState({
      showAddForm: false
    });
  },
  onKeyDown: function(e) {
    if (e.keyCode === 27) {
      return this.setState({
        showAddForm: false
      });
    }
  },
  componentDidMount: function() {
    return document.addEventListener('keydown', this.onKeyDown);
  },
  componentWillUnmount: function() {
    return document.removeEventListener('keydown', this.onKeyDown);
  },
  render: function() {
    var addButton, addComponent, addMatch, matches;
    matches = this.props.matchStore.map(function(match) {
      return React.createElement(Match, React.__spread({
        "key": match.id
      }, match));
    });
    addButton = React.createElement(AddButton, {
      "clickHandler": this.showAddForm
    });
    addMatch = React.createElement(AddMatch, {
      "hideAddForm": this.hideAddForm
    });
    addComponent = this.state.showAddForm ? addMatch : addButton;
    return React.createElement("div", {
      "className": this.props.columnClass + ' match-column'
    }, React.createElement(Info, {
      "pics": this.props.pics
    }), addComponent, matches);
  }
});
