app.service "$attrServ", ->

  (element) ->
    attributes = {};

    if(element)
      $.each(element.get(0).attributes, (index, attr) ->
          attributes[attr.name] = attr.value
      )

    return attributes


app.service "$location", ["$path"], (path) ->

  (url, data) ->
    p = path(url, data)
    window.location = p


#Generic form helpers
app.service "$form", ["$log", "pathWithContext"], ($log, $path) ->

  class Form

    constructor: (selector) ->
      if (selector instanceof jQuery and selector.prop('tagName') is "form") then @$el = selector
      else @$el = $(selector)

      @el = @$el[0]
      arr = @$el.serializeArray()
      @inputs = @$el.find(":input")

      $.each @inputs, (i, input) =>
        $input = $(input)
        name = $input.attr("name")
        if name
          @["$#{name}"] = $input

    reset: () =>
      $log.debug "[reset] form", @
      @el.reset()

    submit: () =>
      $log.debug "[submit] form", @
      @el.submit()

    data: () =>
      new FormData(@el)

    post: (url, data = {}) =>
      formData = @data()

      if(not _.isEmpty(data))
        _.each(data, (val, key) -> formData.append(key, val))

      $.ajax(url:$path(url), data:formData, type:"POST", processData:false, contentType:false)


  (selector) ->
    form = new Form(selector)

    handler =
      get: (f, name) ->
        if form[name]? then return form[name]
        else return form["$#{name}"].val()

      set: (f, name, val) ->
        if _.has(form, name) then form[name] = val
        else form["$#{name}"].val(val)

    p = new Proxy(form, handler)

    return p



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


app.module "$log", ->
  log:   -> console.log.apply(console, arguments)
  info:  -> console.info.apply(console, arguments)
  debug: -> console.debug.apply(console, arguments)
  error: -> console.error.apply(console, arguments)
