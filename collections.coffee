@ZeroConfig = _.extend @ZeroConfig,

  _getCollections: ->
    ###
    # This is currently not getting collections defined in packages

    # Mongo.Collection.getAll()
    ###

    # Cycle through top level objects
    _global = @_getGlobalObj()
    _collections = []

    for key in _.keys(_global)
      obj = _global[key]
      if @_isCollection(obj) and not _.contains(@_defaultIgnoredCollections, key)
        _collections.push
          name: key
          _name: obj._name
          instance: obj

    # Add users schema
    _collections.push
      name: "Meteor.users"
      instance: Meteor.users

    _collections

    # Add schema
