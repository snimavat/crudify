app.service "relationSelectServ", ["$log", "pathWithContext"], ($log, pathWithContext) ->

  (path) ->
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
            table = dialog.find("table.table tr.highlight")
            if(table.length > 0)
              row = table.first()
              data =
                value: row.data('row-value') ? row.data("row-id")
                display: row.data("display")

            deferred.resolve(data, row) if data?
            return data?
    }

    dialog.init ()->
      promise = $.get(pathWithContext(path))
      promise.done (data) ->
        dialog.find('.bootbox-body').html(data)
        table = dialog.find("table.table tr")
        table.click () ->
          selected = $(this).hasClass("highlight")
          table.removeClass("highlight")
          if(!selected)
            $(this).addClass("highlight")


    deferred.promise()
