@redraw_results = (result_json) ->
  "use strict"
  $(".results-wrapper").html('')
  result_json.forEach((el) ->
    $(".results-wrapper").append($(draw_node(el)))
  )

@draw_node = (el_object) ->
  wrapper = $('<div/>', {class: 'well'})
  title_a = $('<a/>', {
    href: el_object.original_uri,
    text: el_object.title
  })
  descr = $('<div/>')
  $(descr).html(el_object.teaser)
  vote_links = $('<div/>')
  vote_links.append($("<a/>", {href: '/main/vote_up/'+el_object.id, text: 'Vote UP'}))
  vote_links.append("&nbsp;|&nbsp;")
  vote_links.append($("<a/>", {href: '/main/vote_down/'+el_object.id, text: 'Vote DOWN'}))

  wrapper.append(title_a)
  wrapper.append(descr)
  wrapper.append(vote_links)
  return wrapper