app.service "$attr", ->

  (element) ->
    attributes = {};

    if(element)
      $.each(element.get(0).attributes, (index, attr) ->
          attributes[attr.name] = attr.value
      )

    return attributes


#Generic form helpers
app.service "$form", ["$log"], ($log) ->

  class Form

    constructor: (selector) ->
      if (selector instanceof jQuery and selector.prop('tagName') is "form") then @$el = selector
      else @$el = $(selector)

      @el = @$el[0]
      arr = @$el.serializeArray()
      @inputs = $.map(arr, (n, i) -> n.name)

      $.each @inputs, (i, name) =>
        $input = @$el.find("[name=#{name}]")
        @["$#{name}"]  = $input


    reset: () =>
      $log.debug "[reset] form", @
      @el.reset()

    submit: () =>
      $log.debug "[submit] form", @
      @el.submit()


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


