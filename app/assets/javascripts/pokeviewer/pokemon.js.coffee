$ ->
  $(".pc-pokemon").mouseover ->
    $(this).children(".pc-data").show()
  $(".pc-pokemon").mouseout ->
    $(this).children(".pc-data").hide()
  $(".pc-pokemon").mousemove (event) ->
    $(this).children(".pc-data").offset({left: event.pageX + 16, top: event.pageY - 16})
