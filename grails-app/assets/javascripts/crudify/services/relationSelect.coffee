
###
  Displays the response of given path in dialog.
  and returns a promise which is resolved with the selected row.

  Response must have a selectable list
###
app.service "relationSelectServ", ["$log", "pathWithContext"], ($log, pathWithContext) ->

  (path, params = {}) ->
    deferred = $.Deferred()
    dialog = bootbox.dialog {
      title: 'Select'
      message: '<p><i class="fa fa-spin fa-spinner"></i> Loading...</p>'
      buttons:
        cancel:
          label: 'Cancel',
          className: 'btn-danger'
          callback: () ->
            deferred.reject()

        select:
          label: 'Select',
          className: 'btn-success',
          callback: () ->
            data = undefined
            table = dialog.find(".selectable-list .selected")
            if(table.length > 0)
              row = table.first()
              data =
                value: row.data('row-value') ? row.data("row-id")
                display: row.data("display")

            deferred.resolve(data, row) if data?
            return data?
    }

    dialog.init ()->
      promise = $.get(pathWithContext(path), params)
      promise.done (data) ->
        dialog.find('.bootbox-body').html(data)


    deferred.promise()
