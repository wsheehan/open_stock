import Ember from 'ember';

export default Ember.Component.extend({
  click() {
    this.sendAction('listenToCompany', this.get('ticker'));
  }
});
