@ZeroConfig = _.extend @ZeroConfig,
  storeProtoSchemas: ->
    _.each ZeroConfig._getCollections(), (c) ->
      protoSchema = ZeroConfig._generateProtoSchema(c)
      protoSchema = EJSON.stringify protoSchema
      ZeroConfig.AdminCollections.upsert {name: c.name}, {
        $set: {
          protoSchema: protoSchema
        }
      }
