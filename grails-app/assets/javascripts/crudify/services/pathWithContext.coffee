app.service "pathWithContext", ->

  (path, params) ->
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