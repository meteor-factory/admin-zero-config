Meteor.startup ->
  ZeroConfig.storeProtoSchemas()
  console.log ZeroConfig.getAdminConfig()
