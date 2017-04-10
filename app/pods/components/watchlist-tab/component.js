import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['watchlist-tab'],

  click() {
    this.sendAction('selectWatchlist', this.get('watchlist'));
  }
});
