React = require 'react'
Component = React.Component
PropTypes = React.PropTypes
Redux = require 'redux'
connect = require('react-redux').connect
Columns = require './columns'
pairActions = require './actions/pairs'
teamActions = require './actions/teams'
matchActions = require './actions/matches'

class App extends Component
  render: ->
    return (
      <div>
        <Columns
          pairs={@props.pairs}
          teams={@props.teams}
          matches={@props.matches}
          actions={@props.actions}
        />
      </div>
    )

App.propTypes =
  pairs: PropTypes.object.isRequired,
  actions: PropTypes.object.isRequired

mapStateToProps = (state) ->
  pairs: state.pairs
  teams: state.teams
  matches: state.matches

mapDispatchToProps = (dispatch) ->
  allActions = Object.assign {}, teamActions, pairActions, matchActions
  actions: Redux.bindActionCreators allActions, dispatch


module.exports = connect(
  mapStateToProps,
  mapDispatchToProps
)(App)