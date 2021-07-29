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

  $.delete = (url, data = {}) ->
    return $.ajax({
      'type': 'DELETE',
      'url': url,
      'contentType': 'application/json',
      'data':JSON.stringify(data),
      'dataType': 'json',
    })

  $.fn.tagName = () ->
    return this.prop("tagName").toLowerCase()

#controllers
jQuery ($) ->
  initApp()
  observe($("#main-content"))
  #$(document).ajaxComplete(initApp)
  return

$attrServ = undefined
$log = undefined

initApp = () ->
  $attrServ = app.require("$attrServ")
  $log = app.require("$log")
  body = $("body")
  initDirectives(body)
  initControllers(body)

  $.publish('app.loaded')

initControllers = (elem) ->
  elem = elem ?= $("body")
  elems = elem.find('[controller]')

  $.each elems, (index, elem) ->
    $elem = $(elem)
    initController($elem)

  initController(elem, true)
  return true

initController = ($elem, check = false) ->
  return if check and (not $elem.is("[controller]"))
  if not $elem.hasClass("$ctrl")
    name = $elem.attr('controller')
    if(!name) then return
    ctrls = [name]
    if name.includes(",")
      ctrls = name.split(",")

    _.each(ctrls, (ctrlName) ->
      $log.debug "Initializing controller", ctrlName, "Element:", $elem
      app.require(ctrlName.trim(), {
        $el: -> $elem
        $attrs: -> $attrServ($elem)
      }))

    $elem.addClass('$ctrl $$touched')

initDirectives = (elem) ->
  elem = elem ? $("body")
  _.each directives, (opts, d) ->
    directive = _.dashed(d)
    restrict = opts.restrict
    selector = directiveRestrict(directive, restrict)
    _.each elem.find(selector), (elem) ->
      $elem = $(elem)
      initDirective($elem, d)

    initDirective(elem, d, true)
  return true

initDirective = ($elem, directive, check = false) ->
  if check
    opts = directives[directive]
    return if not opts
    selector = directiveRestrict(directive, opts.restrict)
    return if not $elem.is(selector)

  if not $elem.hasClass("$dr:#{directive}")
    $log.debug "init:directive ", directive, "Element:", $elem
    app.require(directive, {
      $el: -> $elem
      $attrs: -> $attrServ($elem)
    })

    $elem.addClass("$dr:#{directive} $$touched")

directiveRestrict = (directive, restrict) ->
  arr = []
  selector = undefined

  if(not restrict)
    selector = "#{directive}"
  else
    if restrict.indexOf('E') != -1
      arr.push "#{directive}"

    if restrict.indexOf('A') != -1
      arr.push "[#{directive}]"

    if restrict.indexOf('C') != -1
      arr.push ".#{directive}"

    selector = arr.join(",")

  return selector


#Observer dom and init directives/controllers
observe = (target) ->
  target = target.get(0)
  # Create an observer instance
  ignored = ["LINK", "SCRIPT"]
  observer = new MutationObserver((mutations) ->
    mutations.forEach (mutation) ->
      newNodes = mutation.addedNodes
      # DOM NodeList
      if newNodes != null
        $nodes = $(newNodes)
        # jQuery set
        $nodes.each ->
          #Ignore text nodes or codemirror changes
          return if (this.nodeType is 3) or (this.className.indexOf("CodeMirror") isnt -1)
          return if this.nodeName in ignored
          $node = $(this)
          return if $node.parents(".no-mutation").length > 0
          console.debug 'Node added', $node
          initControllers($node)
          initDirectives($node)
          return
      return
    return
  )
  # Configuration of the observer:
  config =
    childList: true
    subtree: true
    characterData: false
    attributes: false

  if target then observer.observe target, config
  return
