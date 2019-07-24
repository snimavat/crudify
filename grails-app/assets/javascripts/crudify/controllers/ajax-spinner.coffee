
###
  Adds ajax spinner which gets displayed when ajax request is in progress
###
app.controller "ajax-spinner", ["$el", "$log", "pathWithContext"], ($el, $log) ->
  $log.debug("Init Ajax spinner")
  $el.hide()

  $(document).ajaxSend (event, request, settings) ->
    $el.show()

  $(document).ajaxComplete (event, request, settings) ->
    $el.hide()
