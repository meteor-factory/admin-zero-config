@ZeroConfig = _.extend @ZeroConfig,

  _defaultAdminConfig:
    name: "App"
    collections: []
    dashboard:
      homeUrl: '/'

  getAdminConfig: ->
    collections = @_getCollections()

    collections = _.map collections, (collection) ->
      if collection.instance._c2
        console.log "#{collection.name} has schema"
        collection
      else
        console.log "#{collection.name} has NO schema"
