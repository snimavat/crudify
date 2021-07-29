#Generic Drawer
app.service "modal", ["$log"], ($log) ->

  class Dialog
    deferred = $.Deferred()
    modal = undefined
    constructor: (selector) ->
      container = undefined
      if(selector) then container = $(selector)
      else
        container = $("<div/>")
        container.addClass("modal")
        container.data("$d", true)
        container.append("""<div class="modal-body w-full lg:w-1/2 m-5 lg:m-0 p-4">""")
        $('#main-content').append(container)

      @el = container
      @el.data("$modal", @)
      @el.on("click", ".close", clickClose)
      elem = @el
      modal = @

    clickClose = (e) ->
      data = $(this).data()
      modal.close(data)

    escapeHandler = (e) ->
      if(e.keyCode is 27) then modal.close()

    onOpen = () ->
      modal.el.addClass("open")
      modal.el.focus()
      $(document).on "keyup", escapeHandler

    onClose = () ->
      modal.el.removeClass("open")
      modal.el.blur()
      if(modal.el.data("$d"))
        modal.destroy()
      $(document).off "keyup", escapeHandler

    open: (url, data = {}) =>
      if(url) then @load(url, data)
      onOpen()
      deferred = $.Deferred()
      return deferred

    close: (data = undefined) =>
      @el.trigger("closed", data)
      onClose()
      @el.removeClass("open")
      deferred.resolve(data)

    content: (c) =>
      @el.find(".modal-body").first().html(c)

    clear: () =>
      @el.find(".modal-body").first().html("")

    load: (url, data = {}) =>
      @clear()
      promise =  $.get(url, data)
      promise.done (resp) =>
        @el.find(".modal-body").first().html(resp)
      promise

    on: (evt, callback) =>
      @el.on(evt, callback)

    off: (evt, callback) =>
      @el.off(evt, callback)

    one: (evt, callback) =>
      @el.one(evt, callback)

    reset: () =>
      @el.find(".modal-body").html("")

    destroy: () =>
      @el.remove()


  (selector = undefined ) ->
    if(selector)
      container = $(selector)
      attached = container.data("$modal")
      return attached if attached
    return new Dialog(selector)

