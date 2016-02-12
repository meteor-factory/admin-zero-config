@ZeroConfig = _.extend @ZeroConfig,
  _defaultIgnoredCollections: ['AdminCollectionsCount']

  _getGlobalObj: -> if Meteor.isClient then window else global

  # Ducktyping to determine if collection
  _isCollection: (obj) ->
    _.all [
      typeof obj?.insert is 'function'
      typeof obj?.upsert is 'function'
      typeof obj?.update is 'function'
      typeof obj?.remove is 'function'
    ]
