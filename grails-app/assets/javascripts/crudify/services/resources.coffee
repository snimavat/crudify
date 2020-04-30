#Quick dirty Rest API for Grails based backend
app.service "$resource", ["$log", "pathWithContext"], ($log, pathWithContext) ->

  (url) ->

    class Resource

      constructor: (obj) ->
         @[name] = method for name, method of obj

      _url: (action, params = {}) ->
          id = params.id ? @id
          if id?
            return pathWithContext("#{url}/#{action}/#{id}.json", params)
          else
            return pathWithContext("#{url}/#{action}.json", params)

      this.get = (id, params = {}) ->
        r = new Resource(id:id)
        console.log "[Get]", r._url("get", params)
        promise = $.getJSON(r._url("get", params))
        r.$promise = promise

        promise.done (data) ->
          $.extend(r, data)

        return r

      save: () =>
        url = if (@.id) then @_url("edit") else @_url("create")
        $log.debug "[save]", url, @
        delete @$promise #Remove promise
        promise = $.postJSON(url, @)
        @$promise = promise
        promise.done (data, textStatus, jqXHR) =>
          $.extend(@, data)
          @id = data.id #XXX hack - id is not being copied otherwise

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

