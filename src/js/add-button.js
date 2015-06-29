var React;

React = require('react');

module.exports = React.createClass({
  render: function() {
    return React.createElement("div", {
      "className": "add-button",
      "onClick": this.props.clickHandler
    }, "\t\t\t+");
  }
});
