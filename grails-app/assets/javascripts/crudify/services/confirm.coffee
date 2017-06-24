#Generic confirm dialog
app.service "$confirm", ["$log"], ($log) ->

  (message = "Are you sure ?", title = "Confirm") ->
    deferred = $.Deferred()

    bootbox.confirm({
      title: title,
      message: message,
      buttons: {
        cancel: {
          label: '<i class="fa fa-times"></i> Cancel'
        },
        confirm: {
          className: 'btn-danger'
          label: '<i class="fa fa-check"></i> Confirm'
        }
      },
      callback: (result) ->
        if(result) then deferred.resolve(true)
        else deferred.reject(false)
    })

    return deferred.promise()


