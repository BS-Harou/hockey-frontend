Redux = require 'redux'
pairs = require './pairs'
teams = require './teams'
matches = require './matches'

rootReducer = Redux.combineReducers({
  pairs
  teams
  matches
})

module.exports = rootReducer