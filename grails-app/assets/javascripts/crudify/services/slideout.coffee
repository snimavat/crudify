#Generic Drawer
app.service "slideout", ["$log"], ($log) ->

  class Slideout
    deferred = $.Deferred()
    drawer = undefined
    constructor: (selector) ->
      container = undefined
      if(selector) then container = $(selector)
      else
        container = $("</div>")
        container.addClass(".slideout")
        $('body').append(container)

      @el = container
      @el.data("slideout", @)
      @el.on("click", ".close", @close)
      elem = @el
      drawer = @

    escapeHandler = (e) ->
      if(e.keyCode is 27) then drawer.close()

    onOpen = () ->
      drawer.el.addClass("open")
      $(document).on "keyup", escapeHandler

    onClose = () ->
      drawer.el.removeClass("open")
      $(document).off "keyup", escapeHandler

    open: (url, data = {}) =>
      if(url) then @load(url, data)
      #@el.css("width", "100%")
      #@el.css("margin-left", "0")
      onOpen()
      deferred = $.Deferred()
      return deferred

    close: (data = undefined) =>
      #@el.css("margin-left", "100%")
      #@el.css("width", "0")
      @el.trigger("closed", data)
      @el.onTransition(onClose)
      @el.removeClass("open")
      deferred.resolve(data)

    clear: () =>
      @el.find(".slideout-body").first().html("")

    load: (url, data = {}) =>
      @clear()
      promise =  $.get(url, data)
      promise.done (resp) =>
        @el.find(".slideout-body").first().html(resp)
      promise

    on: (evt, callback) =>
      @el.on(evt, callback)

    off: (evt, callback) =>
      @el.off(evt, callback)

    one: (evt, callback) =>
      @el.one(evt, callback)

    reset: () =>
      $log.info "Closing drawer"
      @el.find(".slideout-body").html("")

    destroy: () =>
      @el.remove()


  (selector = undefined ) ->
    #If this slideout already exist, return it.
    if(selector) then container = $(selector)
    attached = container.data("slideout")
    return attached if attached
    return new Slideout(selector)

