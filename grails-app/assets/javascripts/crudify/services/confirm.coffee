#Generic confirm dialog
app.service "confirm", ["$log", "modal"], ($log, modal) ->

  (message = "Are you sure ?", title = "Confirm") ->
    deferred = $.Deferred()

    content = """
      <div class="flex justify-center items-center">
          <span>#{message}</span>
      </div>
      <div class="flex justify-center items-center mt-4">
         <span class="close btn-rounded bg-warn text-white mr-3" data-confirm="false"><i class="fa fa-times"></i></span>
         <span class="close btn-rounded bg-gray-400" data-confirm="true"><i class="fa fa-check"></i></span>
      </div>
    """

    dialog = modal()
    dialog.content(content)
    promise = dialog.open()
    promise.done (data) ->
      if(data.confirm) then deferred.resolve true
      else deferred.reject false

    return deferred

app.service "notify", ["$log", "modal"], ($log, modal) ->

  (message = "Hello", title = "Confirm") ->
    deferred = $.Deferred()

    content = """
      <div class="flex justify-center items-center">
          <span>#{message}</span>
      </div>
      <div class="flex justify-center items-center mt-4">
         <span class="close btn-rounded bg-warn text-white mr-3" data-confirm="false"><i class="fa fa-times"></i></span>
      </div>
    """

    dialog = modal()
    dialog.content(content)
    promise = dialog.open()
    promise.done (data) ->
      if(data.confirm) then deferred.resolve true
      else deferred.reject false
    return deferred