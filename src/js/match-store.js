var Backbone, MatchCollection, MatchModel,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Backbone = require('backbone');

MatchModel = (function(superClass) {
  extend(MatchModel, superClass);

  function MatchModel() {
    return MatchModel.__super__.constructor.apply(this, arguments);
  }

  MatchModel.prototype.idAttribute = '_id';

  return MatchModel;

})(Backbone.Model);

MatchCollection = (function(superClass) {
  extend(MatchCollection, superClass);

  function MatchCollection() {
    return MatchCollection.__super__.constructor.apply(this, arguments);
  }

  MatchCollection.prototype.model = MatchModel;

  MatchCollection.prototype.initialize = function() {
    return this.listenToOnce(app, 'start', this.onAppStart);
  };

  MatchCollection.prototype.onAppStart = function() {
    return app.socket.emit('data', {
      endpoint: '/matches/list'
    });
  };

  MatchCollection.prototype.comparator = function(a) {

    /*return -1 if parseInt(a.date, 10) > parseInt(b.date, 10)
    		return 1
     */
    return -parseInt(a.get('date'), 10);
  };

  return MatchCollection;

})(Backbone.Collection);

module.exports = MatchCollection;
