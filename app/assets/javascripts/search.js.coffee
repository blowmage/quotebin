# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#q').autocomplete
    appendToType: $('#q-autocomplete'),
    source: $('#q').data('autocomplete-source'),
    select: (event, ui) ->
         $(this).val(ui.item.value).parents("form").submit();
