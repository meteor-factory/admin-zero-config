@ZeroConfig = _.extend @ZeroConfig,
  _getName: -> if Meteor.isClient then document.title else "App"

  _defaultIgnoredCollections: ['AdminCollectionsCount']

  _getGlobalObj: -> if Meteor.isClient then window else global

  # Ducktyping to determine if collection
  _isCollection: (obj) ->
    obj instanceof Mongo.Collection
