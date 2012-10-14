# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#q').autocomplete
    appendTo: $(".page__search")
    source: $('#q').data('autocomplete-source')
    select: (event, ui) -> window.location.href = ui.item.url

  $('#q').data("autocomplete")._renderItem = (ul, item) ->
    item.value = $("#q").val()
    $('<li>').data("item.autocomplete", item).append( "<a>" + item.label + "</a>" ).appendTo ul
