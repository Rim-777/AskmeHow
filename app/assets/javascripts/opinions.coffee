$(document).ready ->
  $("form.button_to").bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('#rating_' + response.opinionable_class + '_' + response.id + '_result').html(response.rating)
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    message_box = $("#" + errors.opinionable_class + '_' + errors.id + '_errors')
    message_box.show()
    message_box.html(errors.error_message)
    message_box.fadeOut(2000).delay(2000)


