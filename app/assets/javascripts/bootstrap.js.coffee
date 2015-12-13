jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$(document).ready ->
  $("#search_form").on("ajax:success", (e, data, status, xhr) ->
    response = JSON.parse(xhr.responseText)
    redraw_results(response)
  ).on "ajax:error", (e, xhr, status, error) ->
    $(".results-wrapper").append "<p>ERROR</p>"