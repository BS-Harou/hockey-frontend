var React;

React = require('react');

module.exports = React.createClass({
  onAddClick: function() {
    return alert('kambate');
  },
  render: function() {
    return React.createElement("div", {
      "className": "add-button",
      "onClick": this.props.clickHandler
    }, "\t\t\t+");
  }
});
