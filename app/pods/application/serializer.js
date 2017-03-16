import DS from 'ember-data';

export default DS.RESTSerializer.extend({
  keyForAttribute(attr, method) {
    return Ember.String.underscore(attr);
  }
});
