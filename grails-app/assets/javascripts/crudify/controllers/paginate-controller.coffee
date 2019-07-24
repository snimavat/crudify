
app.controller "paginate", ["$el", "$attrs", "$log", "pathWithContext"], ($el, $attrs, $log, path) ->
  rowsPerPage = if $attrs['page-size'] then parseInt($attrs['page-size']) else 10

  url = path($attrs.url)
  placeholder = $attrs.update
  target = $(placeholder);

  if not $attrs.total
    promise = $.get(url)
    promise.done (data) ->
      $log.debug data
      total = data.total
  else
    total = parseInt($attrs.total)

  if total <= rowsPerPage then $el.hide()

  totalPages = 1
  if total > rowsPerPage
    $log.debug Math.ceil(total / rowsPerPage)
    totalPages = Math.ceil(total / rowsPerPage)

  loadPage = (page) ->
    return if not page

    params = if $el.data() then $el.data() else {}
    params["page"] = page
    delete params['twbsPagination'] #TODO its a Hack

    promise = $.get(path(url), params)
    promise.done (data) ->
      target.html(data)

  #Start page - needed when paginated content is loaded through ajax
  startPage = if $attrs['start-page'] then parseInt($attrs['start-page']) else 1

  $el.twbsPagination
    totalPages: totalPages
    visiblePages: 5
    startPage: startPage
    initiateStartPageClick: false
    onPageClick: (event, page) ->
      loadPage(page)

