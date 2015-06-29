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
    this.setState({
      showAddForm: true
    });
  },
  hideAddForm: function() {
    this.setState({
      showAddForm: false
    });
  },
  onKeyDown: function(e) {
    if (e.keyCode === 27) {
      this.setState({
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
    matches = this.props.matchStore.map((function(_this) {
      return function(match) {
        var winPic;
        winPic = match.team1Score > match.team2Score ? _this.props.pair.team1Name.toLowerCase() : _this.props.pair.team2Name.toLowerCase();
        return React.createElement(Match, React.__spread({
          "key": match._id,
          "winPic": winPic,
          "pair": _this.props.pair
        }, match));
      };
    })(this));
    addButton = React.createElement(AddButton, {
      "clickHandler": this.showAddForm
    });
    addMatch = React.createElement(AddMatch, {
      "pair": this.props.pair,
      "hideAddForm": this.hideAddForm
    });
    addComponent = this.state.showAddForm ? addMatch : addButton;
    return React.createElement("div", {
      "className": this.props.columnClass + ' match-column'
    }, React.createElement(Info, {
      "pair": this.props.pair,
      "pics": this.props.pics
    }), addComponent, matches);
  }
});
