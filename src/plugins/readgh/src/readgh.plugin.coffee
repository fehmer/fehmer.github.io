# Export Plugin
module.exports = (BasePlugin) ->
  # Define Plugin
  class ReadGh extends BasePlugin
    # Plugin name
    name: 'readGh'

    constructor: ->
      # Prepare
      super
      console.log('read from gh')

    # Populate Collections
    populateCollections: (opts,next) ->
      # Prepare
      config = @config
      docpad = @docpad

      console.log('read from gh')
      # Chain
      @