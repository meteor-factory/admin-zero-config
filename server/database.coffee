@ZeroConfig = _.extend @ZeroConfig,
  storeProtoSchemas: ->
    _.each ZeroConfig._getCollections(), (c) ->
      protoSchema = ZeroConfig._generateProtoSchema(c)
      protoSchema = EJSON.stringify protoSchema
      console.log(c)
      ZeroConfig.AdminCollections.upsert {name: c.name}, {
        $set: {
          protoSchema: protoSchema
          _name: c.instance._name
        }
      }
