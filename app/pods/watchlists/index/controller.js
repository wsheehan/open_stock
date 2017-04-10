import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    selectWatchlist(watchlist) {
      this.set('selectedWatchlist', watchlist);
    }
  }
});
