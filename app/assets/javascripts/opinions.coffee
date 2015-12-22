$(document).ready ->
  $("form.button_to").bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('#rating_' + response.opinionable_class + '_' + response.id + '_result').html(response.rating)