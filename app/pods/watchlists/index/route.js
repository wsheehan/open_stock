import Ember from 'ember';

export default Ember.Route.extend({
  model() {
    return this.get('store').findAll('watchlist');
  },

  setupController(controller, model) {
    this._super(controller, model);
    controller.set('selectedWatchlist', null);
  },

  actions: {
    selectWatchlist(watchlist) {
      this.set('controller.selectedWatchlist', watchlist);
    }
  }
});
