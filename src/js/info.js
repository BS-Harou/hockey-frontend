var React;

React = require('react');

module.exports = React.createClass({
  render: function() {
    return React.createElement("div", {
      "className": 'info'
    }, React.createElement("img", {
      "src": './src/assets/' + this.props.pics[0] + '.svg',
      "height": "40"
    }), "\t\t\t\u00a0\n\t\t\tBOS vs PHI\n\t\t\t\u00a0", React.createElement("img", {
      "src": './src/assets/' + this.props.pics[1] + '.svg',
      "height": "40"
    }));
  }
});
