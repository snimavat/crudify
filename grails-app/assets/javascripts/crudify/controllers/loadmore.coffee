
app.controller "loadmore", ["$el", "$attrs", "$log", "pathWithContext", "$scroll"], ($el, $attrs, $log, path, $scroll) ->
  rowsPerPage = if $attrs['page-size'] then parseInt($attrs['page-size']) else 10

  url = path($attrs.url)
  placeholder = $attrs.update
  target = $(placeholder)

  total = parseInt($attrs.total)

  totalPages = 1

  if total > rowsPerPage
    $log.debug Math.ceil(total / rowsPerPage)
    totalPages = Math.ceil(total / rowsPerPage)

  disable = () ->
    $el.attr('disabled', true)

  if total <= rowsPerPage
    $el.hide()
    disable()

  loadPage = (page) ->
    return if not page

    params = if $el.data() then $el.data() else {}
    params["page"] = page

    promise = $.get(path(url), params)
    promise.done (data) ->
      target.append(data)
      $el.data("current-page", page)
      $scroll($el)
      if(page >= totalPages) then disable()

  #Start page - needed when paginated content is loaded through ajax
  startPage = if $attrs['start-page'] then parseInt($attrs['start-page']) else 1

  onClick = () ->
    page = _.safe($el.data('current-page'), "1")
    page = parseInt(page)
    page = page + 1
    loadPage(page)

  $el.on "click", onClick
