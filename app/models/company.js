import DS from 'ember-data';

export default DS.Model.extend({
  ticker: DS.attr(),
  shortDescription: DS.attr(),
  sector: DS.attr(),
  name: DS.attr()
});
