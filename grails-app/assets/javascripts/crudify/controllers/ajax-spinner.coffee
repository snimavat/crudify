
app.controller "ajax-spinner", ["$el", "$log", "pathWithContext"], ($el) ->
  $el.hide()

  $(document).ajaxSend (event, request, settings) ->
    $el.show()

  $(document).ajaxComplete (event, request, settings) ->
    $el.hide()
