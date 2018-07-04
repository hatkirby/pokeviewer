show_pokemon_tab = (tab) ->
  $(".pokemon-tab").hide()
  $(".ptabe-button").removeClass("active")
  $(".pokemon-" + tab).show()
  $(".ptabe-" + tab).addClass("active")

$ ->
  $(".pkv-has-hover").mouseover ->
    $(this).children(".pkv-hover").show()
  $(".pkv-has-hover").mouseout ->
    $(this).children(".pkv-hover").hide()
  $(".pkv-has-hover").mousemove (event) ->
    $(this).children(".pkv-hover").offset({left: event.pageX + 16, top: event.pageY - 16})
  $(".in-emerald .pokemon-image img").mouseover ->
    $(this).attr("src", $(this)[0].src)
  $(".ptabe-button a").click ->
    show_pokemon_tab($(this).data("tab"))
  if $("#pokemon-embed").length > 0
    show_pokemon_tab("details")
