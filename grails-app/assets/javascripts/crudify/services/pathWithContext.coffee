

pathWithContext = (path, params) ->
  if not path then throw ("path is required")
  context = $('body').data('context');
  uri = ""

  if(context == undefined) then throw ("context path not defined")

  if(!path.startsWith("/"))
    uri = context + "/" + path
  else
    uri = context + path

  if(_.size(params) > 0)
    uri = uri + "?" + $.param(params)

  return uri


app.service "pathWithContext", -> pathWithContext
app.service "$path", -> pathWithContext
