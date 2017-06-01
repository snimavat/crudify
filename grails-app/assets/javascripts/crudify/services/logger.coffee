app.module "$log", ->
  log:   -> console.log.apply(console, arguments)
  info:  -> console.info.apply(console, arguments)
  debug: -> console.debug.apply(console, arguments)
  error: -> console.error.apply(console, arguments)
