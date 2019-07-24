_.templateSettings = {
  interpolate: /\{\{(.+?)\}\}/g
}

console.log "Adding underscopre mixins"
if(not _) then throw ("_ is not loaded")

safe = (arg, val) ->
  if (arg) then return arg else return val

dashed = (str) ->
  str.replace(/([a-z])([A-Z])/g, '$1-$2').toLowerCase()

_.mixin({
  safe: safe
  dashed: dashed
})