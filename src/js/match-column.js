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
    var addButton, addComponent, addMatch, matchStore, matches, team1Wins, team2Wins;
    team1Wins = 0;
    team2Wins = 0;
    matchStore = this.props.matchStore.slice().reverse();
    matches = matchStore.map((function(_this) {
      return function(match) {
        var st;
        if (parseInt(match.team1Score, 10) > parseInt(match.team2Score, 10)) {
          team1Wins++;
        }
        if (parseInt(match.team2Score, 10) > parseInt(match.team1Score, 10)) {
          team2Wins++;
        }
        st = null;
        if (team1Wins > 3) {
          st = {
            background: 'red'
          };
        }
        if (team2Wins > 3) {
          st = {
            background: 'yellow'
          };
        }
        if (team1Wins > 3 || team2Wins > 3) {
          team1Wins = team2Wins = 0;
        }
        return React.createElement(Match, React.__spread({
          "key": match._id,
          "st": st,
          "pair": _this.props.pair
        }, match));
      };
    })(this));
    matches.reverse();
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
