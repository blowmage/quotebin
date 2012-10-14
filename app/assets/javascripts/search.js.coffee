window.openQuoteEditor = ->
  found = $('.js-add-quote-from-search').text()
  if found
    found = found.replace(/['"]/g,'')
    $('.quote-creator__quote textarea').val(found)
  $('.quote-creator__quote textarea').focus()
  $(".js-quote-creator").addClass("state_active")

window.closeQuoteEditor = ->
  $(".js-quote-creator").removeClass("state_active")
  $('.quote-creator__quote textarea').val('')

jQuery ->

  # $('#new_quote').submit( (e) ->
  # )

  $('.quote-creator').keydown( (e) ->
    window.closeQuoteEditor() if e.keyCode == 27
  )

  $(".js-add-quote").click( ->
    window.openQuoteEditor()
  )

  $(".js-cancel-quote").click( ->
    window.closeQuoteEditor()
  )

  $('#q').autocomplete
    appendTo: $(".page__search")
    source: $('#q').data('autocomplete-source')
    select: (event, ui) -> window.location.href = ui.item.url

  $('#q').data("autocomplete")._renderItem = (ul, item) ->
    item.value = $("#q").val()
    $('<li>').data("item.autocomplete", item).append( "<a>" + item.label + "</a>" ).appendTo ul

