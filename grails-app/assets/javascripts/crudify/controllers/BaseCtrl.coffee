

class @BaseCtrl
  excluded = ['extend']
  defaultActions =
    input: "change"
    button: "click"
    a: "click"

  initTargets = (ctrl, targets) ->
    for t in targets
      t = $(t)
      elName = t.attr("el-target")
      if elName
        ctrl["#{elName}El"] = t

    return

  initActions = (ctrl, targets) ->
    for t in targets
      t = $(t)
      val = t.attr("el-action")
      if val
        for part in val.split(",")
          arr = part.split("#")
          event = undefined
          action = undefined
          if arr.length > 1
            event = arr[0]
            action = arr[1]
          else if arr.length is 1
            event =  defaultActions[t.tagName()] ? "click"
            action = arr[0]

          if action and event
            handler = ctrl[action]
            if handler then t.on event, _.partial(_.bind(handler, ctrl),  _, t)

    return

  constructor: () ->
    deps = @.constructor["$inject"]
    @[dep] = arguments[index] for dep, index in deps

    el = @$el

    initTargets(@, el.find("[el-target]"))
    initActions(@, el.find("[el-action]"))

    console.log @

    if _.isFunction(@init)
      @init.call(@, arguments...)

  extend: (obj) ->
    for key, value of obj when key not in excluded
      @[key] = value

  data: (name) =>
    return @$el.data(name)

  attr: (name) =>
    return @$attrs[name]

  bind: (fn, t = @) =>
    _.bind(fn, t)
