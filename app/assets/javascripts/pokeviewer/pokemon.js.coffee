$ ->
  $(".pkv-has-hover").mouseover ->
    $(this).children(".pkv-hover").show()
  $(".pkv-has-hover").mouseout ->
    $(this).children(".pkv-hover").hide()
  $(".pkv-has-hover").mousemove (event) ->
    $(this).children(".pkv-hover").offset({left: event.pageX + 16, top: event.pageY - 16})
  $(".in-emerald .pokemon-image img").mouseover ->
    $(this).attr("src", $(this)[0].src)
