#A simple module system with DI based on pods.js

console.log "Modularized.js called"

window.app = {}
app.pod = new Pod()

app.module = (name, deps, fn) ->
  this.pod.define(name, deps, fn);

app.declare = (name, exports) ->
  this.pod.declare(name, exports)

app.require = (name, deps, callback) ->
  app.pod.require(name, deps, callback)

app.service = app.module
app.controller = app.module
app.value = app.declare

app.declare("$", jQuery);

jQuery ($) ->
  $.postJSON = (url, data) ->
    return $.ajax({
      'type': 'POST',
      'url': url,
      'contentType': 'application/json',
      'data':JSON.stringify(data),
      'dataType': 'json',
    })



#controllers
jQuery ($) ->
  initControllers()

  $(document).ajaxComplete(initControllers)



initControllers = () ->
  elems = $('[controller]')
  $attrServ = app.require("$attr")
  $log = app.require("$log")

  $.each elems, (index, elem) ->
    $elem = $(elem)
    if not $elem.hasClass("$ctrl")
      name = $elem.attr('controller')
      $log.debug "Initializing controller", name, "Element:", $elem
      mod = app.require(name, {
        $el: -> $elem
        $attrs: -> $attrServ($elem)
      })

      $elem.addClass('$ctrl')
