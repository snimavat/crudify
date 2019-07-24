app.service "$scroll", ["$log"], ($log) ->

  (target) ->
    if(target instanceof $)
      $("html, body").animate({ scrollTop: target.offset().top }, 1000)
    else if (typeof value is 'string')
      $("html, body").animate({ scrollTop: $(target).offset().top }, 1000)
