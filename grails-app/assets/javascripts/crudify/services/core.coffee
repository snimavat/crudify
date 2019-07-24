app.service "$attrServ", ->

  (element) ->
    attributes = {};

    if(element)
      $.each(element.get(0).attributes, (index, attr) ->
          attributes[attr.name] = attr.value
      )

    return attributes

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


