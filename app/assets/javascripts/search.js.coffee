# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#q').autocomplete
    appendTo: $(".page__search")
    source: $('#q').data('autocomplete-source')
    select: (event, ui) -> window.location.href = ui.item.url
    open: ->
      search = $("#q").val()
      searchItem =
        value: search
        url: "/search?q=#{search}"
      createItem =
        value: search
        url: "/profile/quotes/new"
      $(this).data("autocomplete").menu.element.append($('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", searchItem).append("<a class='ui-corner-all'>Search: \"#{search}\"</a>"))
      $(this).data("autocomplete").menu.element.append($('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", createItem).append("<a class='ui-corner-all'>Create a Quote</a>"))

  $('#q').data("autocomplete")._renderItem = (ul, item) ->
    item.value = $("#q").val()
    $('<li class="ui-menu-item" role="menuitem">').data("item.autocomplete", item).append("<a class='ui-corner-all'>\"#{item.term}\" by #{item.author}</a>").appendTo ul
