Meteor.startup ->
  collections = ZeroConfig._getCollections()
  console.log(collections)
  _.each collections, (c) ->
    c.instance._adminSchema = true
