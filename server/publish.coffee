Meteor.publish 'adminCollections', ->
  unless Roles.userIsInRole this.userId, ['admin']
    return @ready()

  ZeroConfig.AdminCollections.find()
