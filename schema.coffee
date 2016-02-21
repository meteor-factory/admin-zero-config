_getKeysByValue = (obj, key, isArray) ->
  isArray = isArray || false;
  # console.log key
  schemaKey = {}

  if typeof obj is 'string'
    schemaKey[key] = if isArray then '[string]' else 'string';
    return schemaKey

    if typeof obj is 'number'
      schemaKey[key] = if isArray then '[number]' else 'number'
      return schemaKey

  if typeof obj is 'boolean'
    schemaKey[key] = 'boolean'
    return schemaKey


  if obj instanceof Date
    schemaKey[key] = 'date'
    return schemaKey

  if _.isArray obj
    _getKeysByValue(obj[0], key, true)

  else

    for i of obj
      if obj.hasOwnProperty(i)
        _getKeysByValue(obj[i], key + (if isArray then ".$." else ".") + i)

@ZeroConfig = _.extend @ZeroConfig,
  _getDocSample: (collection) ->
    docs = collection.instance.find({}, {limit: 10}).fetch()

    unless docs.length
      # No documents. Cannot generate schema
      return

    # Get as many properties as possible
    _superDoc = docs[0]
    _.each docs, (doc) ->
      _superDoc = _.extend _superDoc, doc
    _superDoc

  # Generates a JSON schema that can be stored in a collection
  _generateProtoSchema: (collection) ->
    console.log "Generating schema for #{collection.name}"
    doc = @_getDocSample(collection)
    console.log(doc);
    _schemaObj = []

    _.each doc, (v, k) ->
      schemaKey = {}

      # Can't Handle functions
      if typeof v is 'function'
        return

      schemaKey = _getKeysByValue(v, k)
      _schemaObj.push schemaKey

    _schemaObj = _.flatten _schemaObj
    return _schemaObj

  _getSchemaKey: (value) ->
    if typeof value is 'string'
      type = String

    if value instanceof Date
      type = Date

    type: type

  _mapProtoSchema: (protoSchema) ->
    console.log(protoSchema)
    _schemaSeed = {}

    for item in protoSchema
      key = _.keys(item)[0]
      propertyType =  _.values(item)[0]

      # TODO: Clean up code
      if propertyType == 'string'
        propertyType = String

      if propertyType == 'number'
        propertyType = Number

      if propertyType == 'boolean'
        propertyType = 'Boolean'

      if propertyType == '[string]'
        propertyType = [String]

      if propertyType == '[number]'
        propertyType = [Number]


      _schemaSeed[key] =
        type: propertyType
        optional: true

      # Remove _id
      delete _schemaSeed._id

    _schemaSeed


  _generateSchema: (collection) ->
    protoSchema = @_generateProtoSchema(collection)
    schemaSeed = @_mapProtoSchema(protoSchema)

    console.log(schemaSeed)

    protoSchema
