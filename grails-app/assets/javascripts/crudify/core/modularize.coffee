#A simple module system with DI based on pods.js
#Controllers, directives, and services.

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

directives = {}

#Arg2 can be a factory or options object
app.directive = (name, opts, factory) ->
  if _.isFunction(opts)
    directives[name] = {}
    app.module(name, opts)
  else
    directives[name] = opts
    app.module(name, factory)


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
  initApp()
  $(document).ajaxComplete(initApp)

initApp = () ->
  initDirectives()
  initControllers()
  $.publish('app.loaded')

initControllers = () ->
  elems = $('[controller]')
  $attrServ = app.require("$attrServ")
  $log = app.require("$log")

  $.each elems, (index, elem) ->
    $elem = $(elem)
    if not $elem.hasClass("$ctrl")
      name = $elem.attr('controller')
      if(!name) then return
      $log.debug "Initializing controller", name, "Element:", $elem
      mod = app.require(name, {
        $el: -> $elem
        $attrs: -> $attrServ($elem)
      })

      $elem.addClass('$ctrl')

initDirectives = () ->
  $attrServ = app.require("$attrServ")
  $log = app.require("$log")

  _.each directives, (opts, d) ->
    directive = _.dashed(d)
    restrict = opts.restrict
    selector = undefined

    if(not restrict)
      selector = "#{directive}, [#{directive}], .#{directive}"
    else
      arr = []
      if restrict.indexOf('E') != -1
        arr.push "#{directive}"

      if restrict.indexOf('A') != -1
        arr.push "[#{directive}]"

      if restrict.indexOf('C') != -1
        arr.push ".#{directive}"

      selector = arr.join(",")

    _.each $(selector), (elem) ->
      $elem = $(elem)
      if not $elem.hasClass("$dr:#{directive}")
        $log.debug "init:directive ", d, "Element:", $elem
        app.require(d, {
          $el: -> $elem
          $attrs: -> $attrServ($elem)
        })

        $elem.addClass("$dr:#{directive}")