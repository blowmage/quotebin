# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#q').autocomplete
    appendTo: $(".page__search")
    source: $('#q').data('autocomplete-source')
    select: (event, ui) -> window.location.href = ui.item.value
    open: ->
      item = value: null
      $(this).data("autocomplete").menu.element.append($('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", item).append("<a class='ui-corner-all' href='/blowmage'>Mike is AWESOME!!!</a>"))
      $(this).data("autocomplete").menu.element.append($('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", item).append("<a class='ui-corner-all' href='/profile/quotes/new'>Create a Quote</a>"))
  $('#q').data("autocomplete")._renderItem = (ul, item) ->
    $('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", item).append("<a class='ui-corner-all'>\"#{item.term}\" by #{item.author}</a>").appendTo ul
