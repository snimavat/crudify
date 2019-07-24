
#A tax box based remote search
app.controller "remoteSearch", ["$el", "$attrs", "$attrServ", "$log", "pathWithContext"], ($el, $attrs, $attrServ, $log, path) ->
  $log.debug "[remoteSearch] Init"

  xhr = null
  lastVal = null

  search = () ->
    val = $el.val()
    if val and val is lastVal then return #not changed
    if((not val and not lastVal)) then return #empty and no previous search
    if(val and not lastVal and val.length < 3) then return #First with less then 3 chars

    lastVal = val

    data = $el.data()
    data['q'] = val

    $log.debug "[remoteSearch] data: #{data}"

    if xhr then xhr.abort()
    xhr = $.get(path($attrs.path), data)
    xhr.done (data) ->
      $($attrs.target).replaceWith(data)

  debounced = _.debounce(search, 500)
  $el.on("keyup", debounced)