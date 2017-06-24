#Quick dirty Rest API for Grails based backend
app.service "$resource", ["$log", "pathWithContext"], ($log, pathWithContext) ->

  (url) ->

    class Resource

      constructor: (obj) ->
         @[name] = method for name, method of obj

      _url: (action) ->
          id = id ? @id
          pathWithContext("#{url}/#{action}/#{id}.json")

      @get = (id) ->
        Resource r = new Resource(id:id)
        console.log "[Get]", r._url("get")
        promise = $.getJSON(r._url("get"))
        r.$promise = promise

        promise.done (data) ->
          $.extend(r, data)

        return r

      save: () ->
        $log.debug "[save]", @_url("create"), @

        delete @$promise #Remove promise
        promise = $.postJSON(@._url("create"), @)
        @$promise = promise
        promise.done (data, textStatus, jqXHR) ->
          $.extend(@, data)

        return @

      delete: () ->
        $log.debug "[save]", @_url(), @

        delete @$promise #Remove promise
        promise = $.postJSON(@._url("delete"), @)
        @$promise = promise
        promise.done (data, textStatus, jqXHR) ->
          $.extend(@, data)

        return @

    return Resource

