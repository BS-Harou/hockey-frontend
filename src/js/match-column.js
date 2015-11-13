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
    var addButton, addComponent, addMatch, matchStore, matches, series, seriesIndex, team1Wins, team2Wins;
    team1Wins = 0;
    team2Wins = 0;
    matchStore = this.props.matchStore.slice().reverse();
    series = [];
    seriesIndex = 0;
    matchStore.forEach((function(_this) {
      return function(match, i) {
        var serieWon;
        if (!Array.isArray(series[seriesIndex])) {
          series[seriesIndex] = [];
        }
        if (parseInt(match.team1Score, 10) > parseInt(match.team2Score, 10)) {
          team1Wins++;
        }
        if (parseInt(match.team2Score, 10) > parseInt(match.team1Score, 10)) {
          team2Wins++;
        }
        serieWon = false;
        if (team1Wins > 3 || team2Wins > 3) {
          serieWon = true;
        }
        series[seriesIndex].push(React.createElement(Match, React.__spread({
          "key": match._id,
          "pair": _this.props.pair
        }, match)));
        if (serieWon) {
          series[seriesIndex].winningTeam = team1Wins > 3 ? _this.props.pair.team1 : _this.props.pair.team2;
          team1Wins = team2Wins = 0;
          series[seriesIndex].reverse();
          return seriesIndex++;
        } else if (i === matchStore.length - 1) {
          return series[seriesIndex].reverse();
        }
      };
    })(this));
    series.reverse();
    matches = series.map(function(serie, i) {
      var head, ref, winningTeam;
      winningTeam = (ref = app.teamStore.get(serie.winningTeam)) != null ? ref.toJSON() : void 0;
      if (winningTeam) {
        head = React.createElement("img", {
          "src": './src/assets/' + (winningTeam != null ? winningTeam.icon : void 0),
          "height": "48px"
        });
      }
      if (!winningTeam) {
        head = '?';
      }
      return React.createElement("div", {
        "key": 'serie' + i,
        "className": 'serie row'
      }, React.createElement("div", {
        "className": "serie-head row"
      }, head), React.createElement("div", {
        "className": "serie-top row"
      }, "\t\t\t\t\tV\u00edt\u011bz"), serie);
    });
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
