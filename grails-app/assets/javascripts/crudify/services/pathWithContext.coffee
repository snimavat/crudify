app.service "pathWithContext", ->

  (path) ->
    context = $('body').data('context');
    if(context == undefined) then throw ("context path not defined")
    if(!path.startsWith("/")) then return context + "/" + path
    else return context + path
