@ZeroConfig = _.extend @ZeroConfig,

  _getDefaultAdminConfig: ->
    name: @_getName()
    collections: []
    dashboard:
      homeUrl: '/'

  getAdminConfig: ->
    self = @

    #
    # Get Default Schema
    #

    AdminConfig = @_getDefaultAdminConfig()

    #
    # Add collections
    #

    _collections = @_getCollections()

    # Add Schemas
    collections = _.map _collections, (collection) ->
      if collection.instance._c2
        console.log "#{collection.name} has schema"
        collection
      else
        console.log "#{collection.name} has NO schema"
        collection.schema = self._generateSchema(collection)
        collection

    # Convert to AdminConfig format
    collections = {}
    _collections = _.each _collections, (collection) ->
      collections[collection.name] = {}

    AdminConfig.collections = collections

    AdminConfig
