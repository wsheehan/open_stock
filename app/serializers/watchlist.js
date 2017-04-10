import DS from 'ember-data';
import ApplicationSerializer from '../pods/application/serializer';

export default ApplicationSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    companies: { embedded: 'always' }
  }
});
