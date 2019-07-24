
###
  relationSelect makes it possible to replace select boxes with dialogs which display list of rows which can be
   selected.

  The dialog should have a selectable list
###
app.controller "relationSelect", ["$el", "$attrServ", "$log", "relationSelectServ"], ($el, $attrServ, $log, relationSelectServ) ->
  $log.debug "[relationSelect] #{$el}"

  selectLink = $el.find("a.rel-select").first()
  clearLink = $el.find("a.rel-remove").first()
  $attrs = $attrServ(selectLink)
  resource = $attrs.resource
  property = $attrs.property

  defaultValue = _.safe($attrs['default-value'], '') #Default value which will be displayed when empty

  form = null

  if $el.attr('form')
    form = $($el.attr('form'))
  else
    form = $el.closest('form');

  hidden = form.find($("[name='#{property}']"))
  visible = form.find($("[name='#{property}-display']"))

  toggleClearLink = () ->
    if(hidden.val()) then clearLink.show() else clearLink.hide()

  toggleClearLink()

  #If this element is bound to another element
  if $attrs.bound?
    boundedElem = $attrs.bound
    $.subscribe('relation.selected', (e, data) ->
      if data.name == boundedElem
        selectLink.removeClass("text-muted")
    )

    $.subscribe('relation.cleared', (e, data) ->
      if data.name == boundedElem #if bounded element is cleared
        selectLink.addClass("text-muted")
        onClear() #Clear current element when bound element is cleared
    )

  setVal = (element, val) ->
    if(element.is('input'))
      element.val(val)
    else
      element.text(val)

  #No value, so set default on init
  if(not hidden.val())
    setVal(visible, defaultValue)

  #Clears the element
  onClear = () ->
    setVal(hidden, '') #Set id on hidden input
    setVal(visible, defaultValue) #Set display value on readonly input
    $.publish('relation.cleared', {name: property})
    toggleClearLink()

  #Row has been selected in dialog
  onSelect = () ->
    #If this select is bounded to another - dont do any thing if the other element has no value yet
    params = {}
    if $attrs.bound?
      boundedElem = $attrs.bound
      boundedValue = form.find($("[name='#{boundedElem}']")).val()
      return if not boundedValue
      params[boundedElem] = boundedValue

    promise = relationSelectServ("admin/#{resource}/list", params)
    promise.then (data) ->
      if data
        setVal(hidden, data.value) #Set id on hidden input
        setVal(visible, data.display) #Set display value on readonly input
        $.publish('relation.selected', {name: property, value: data.value, display: data.display})
        toggleClearLink()
      else
        $log.debug "[relation-select] No row selected for #{property}"

  clearLink.on "click", onClear
  selectLink.on "click", onSelect

