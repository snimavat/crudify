
app.controller "paginate", ["$el", "$log", "pathWithContext",], ($el, $log, pathWithContext) ->
  rowsPerPage = 3
  url = pathWithContext($el.data("url"))
  placeholder = $el.data("update");
  target = $(placeholder);

  if not $el.data('total')
    promise = $.get(url)
    promise.done (data) ->
      $log.debug data
      total = data.total
  else
    total = parseInt($el.data('total'))

  totalPages = 1
  if total > rowsPerPage
    $log.debug Math.ceil(total / rowsPerPage)
    totalPages = Math.ceil(total / rowsPerPage)

  $el.twbsPagination
    totalPages: totalPages
    visiblePages: 10
