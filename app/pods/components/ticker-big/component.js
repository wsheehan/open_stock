import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['ticker-big', 'col-sm-2'],

  click() {
    this.sendAction('listenToCompany', this.get('ticker'));
  }
});
