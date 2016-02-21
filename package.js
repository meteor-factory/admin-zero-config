Package.describe({
  name: 'mfactory:admin-zero-config',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: 'Allows ',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');
  api.use('ecmascript');
  api.use('coffeescript');
  api.use('underscore');

  api.use('dburles:mongo-collection-instances@0.3.4', ['client', 'server']);
  api.use('aldeed:simple-schema@1.5.3');
  api.use('aldeed:collection2@2.8.0');

  api.addFiles('zero-config.coffee');
  api.addFiles('utils.coffee');
  api.addFiles('collections.coffee');
  api.addFiles('schema.coffee');
  api.addFiles('admin-config.coffee');

  api.addFiles('server/startup.coffee', 'server');

});

Package.onTest(function(api) {
  api.use('ecmascript');
  api.use('tinytest');
  api.use('mfactory:admin-zero-config');
  api.addFiles('admin-zero-config-tests.js');
});
