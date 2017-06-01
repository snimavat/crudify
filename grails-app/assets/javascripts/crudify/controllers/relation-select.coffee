
app.controller "relationSelect", ["$el", "$attr", "$log", "relationSelectServ"], ($el, $attr, $log, relationSelectServ) ->
    console.log "######## inside relationSelect"
    selectLink = $el.find("a.rel-select").first()
    clearLink = $el.find("a.rel-remove").first()

    $attrs = $attr(selectLink)
    resource = $attrs.resource
    property = $attrs.property

    form = $el.closest('form');

    hidden = form.find($("[name='#{property}']"))
    visible = form.find($("[name='#{property}-input']"))

    clearLink.on "click", () ->
      hidden.val('') #Set id on hidden input
      visible.val('') #Set display value on readonly input


    selectLink.on "click", () ->

      promise = relationSelectServ("admin/#{resource}/filter")
      promise.then (data) ->
        if data
          hidden.val(data.value) #Set id on hidden input
          visible.val(data.display) #Set display value on readonly input
        else
          $log.debug "[relation-select] No row selected for #{property}"
