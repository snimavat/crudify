
###
  Makes a table or list group selectable.
  Each row should have selectable-row class

  add 'selected' class to a row when clicked.
###

app.controller "selectableList", ["$el", "$attrs", "$log"], ($el, $attrs, $log) ->
  $log.debug "[selectable]", $el

  $el.addClass("selectable-list")

  all = $el.find(".selectable-row")
  all.click () ->
    selected = $(this).hasClass("selected")
    all.removeClass("selected")
    if(!selected)
      $(this).addClass("selected")
