#Generic Drawer
app.service "drawer", ["$log"], ($log) ->

  class Drawer
    deferred = $.Deferred()
    drawer = undefined
    constructor: (selector) ->
      container = undefined
      if(selector) then container = $(selector)
      else
        container = $("</div>")
        container.addClass(".drawer")
        $('body').append(container)

      @el = container
      @el.data("drawer", @)
      @el.on("click", ".close-drawer", @close)
      elem = @el
      drawer = @

    escapeHandler = (e) ->
      if(e.keyCode is 27) then drawer.close()

    onOpen = () ->
      drawer.el.addClass("draweropen")
      $(document).on "keyup", escapeHandler

    onClose = () ->
      drawer.el.removeClass("draweropen")
      $(document).off "keyup", escapeHandler

    open: (url, data = {}) =>
      if(url) then @load(url, data)
      @el.css("width", "100%")
      @el.css("margin-left", "0")

      @el.onTransition(onOpen)
      return deferred

    close: (data = undefined) =>
      @el.css("margin-left", "100%")
      @el.css("width", "0")
      @el.trigger("drawer.closed")
      @el.onTransition(onClose)
      @el.removeClass("draweropen")
      deferred.resolve(data)

    clear: () =>
      @el.find(".drawer-body").first().html("")

    load: (url, data = {}) =>
      @clear()
      promise =  $.get(url, data)
      promise.done (resp) =>
        @el.find(".drawer-body").first().html(resp)
      promise

    on: (evt, callback) =>
      @el.on(evt, callback)

    off: (evt, callback) =>
      @el.off(evt, callback)

    one: (evt, callback) =>
      @el.one(evt, callback)

    reset: () =>
      $log.info "Closing drawer"
      @el.find(".drawer-body").html("")

    destroy: () =>
      @el.remove()


  (selector = undefined ) ->
    return new Drawer(selector)

