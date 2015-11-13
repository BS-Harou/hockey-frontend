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
  removeMatch: function() {
    var ref;
    if (!confirm('Určitě chcete odstranit tento zápas?')) {
      return;
    }
    if (!((ref = this.props) != null ? ref._id : void 0)) {
      return;
    }
    app.socket.emit('data', {
      endpoint: '/matches/remove',
      value: {
        '_id': this.props._id
      }
    });
  },
  render: function() {
    var ref, ref1, team1, team2, winningTeam;
    team1 = ((ref = app.teamStore.get(this.props.pair.team1)) != null ? ref.toJSON() : void 0) || {};
    team2 = ((ref1 = app.teamStore.get(this.props.pair.team2)) != null ? ref1.toJSON() : void 0) || {};
    winningTeam = parseInt(this.props.team1Score, 10) > parseInt(this.props.team2Score, 10) ? team1 : team2;
    if (!this.state.detail) {
      return React.createElement("div", {
        "className": "match",
        "onClick": this.onClick
      }, React.createElement("div", {
        "className": "row"
      }, React.createElement("div", {
        "className": "row col-xs-6"
      }, React.createElement("div", {
        "className": "row text-left"
      }, React.createElement("div", {
        "className": "image-wrapper"
      }, React.createElement("img", {
        "src": './src/assets/' + winningTeam.icon,
        "height": "24px"
      })), React.createElement("div", {
        "className": "text-wrapper"
      }, winningTeam.name))), React.createElement("div", {
        "className": "row col-xs-6"
      }, team1.abbr, " ", parseInt(this.props.team1Score), " : ", parseInt(this.props.team2Score), " ", team2.abbr)));
    }
    return React.createElement("div", {
      "className": "match",
      "onClick": this.onClick,
      "style": this.props.st
    }, React.createElement("div", {
      "className": "row"
    }, React.createElement("div", {
      "className": "row col-xs-5"
    }, React.createElement("div", {
      "className": "row"
    }, "\t\t\t\t\t\tV\u00edt\u011bz"), React.createElement("div", {
      "className": "row winning-team-icon"
    }, React.createElement("img", {
      "src": './src/assets/' + winningTeam.icon,
      "width": "100%"
    }))), React.createElement("div", {
      "className": "row col-xs-7"
    }, React.createElement("table", {
      "className": "table table-striped"
    }, React.createElement("thead", null, React.createElement("tr", null, React.createElement("th", null), React.createElement("th", null, team1.abbr), React.createElement("th", null, team2.abbr))), React.createElement("tbody", null, React.createElement("tr", null, React.createElement("td", null, "G\u00f3ly"), React.createElement("td", null, this.props.team1Score), React.createElement("td", null, this.props.team2Score)), React.createElement("tr", null, React.createElement("td", null, "St\u0159ely"), React.createElement("td", null, this.props.team1Shots), React.createElement("td", null, this.props.team2Shots)), React.createElement("tr", null, React.createElement("td", null, "Vhazov\u00e1n\u00ed"), React.createElement("td", null, this.props.team1Faceoffs), React.createElement("td", null, this.props.team2Faceoffs)))))), React.createElement("div", {
      "className": "row"
    }, React.createElement("button", {
      "type": "button",
      "className": "btn btn-danger btn-xs",
      "onClick": this.removeMatch
    }, "x")));
  }
});
