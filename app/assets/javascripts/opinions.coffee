$(document).on 'click', '.opinion_button',  (e) ->
  e.preventDefault()
  $("form.button_to").bind 'ajax:success', (e, data, status, xhr) ->
    opinionable = $.parseJSON(xhr.responseText)
    $('#rating_' + opinionable.opinionable_class + '_' + opinionable.id + '_result').html(opinionable.rating)
  .bind 'ajax:error', (e, xhr, status, error) ->
    errors = $.parseJSON(xhr.responseText)
    message_box = $("#" + errors.opinionable_class + '_' + errors.id + '_errors')
    message_box.show()
    message_box.html(errors.error_message)
    message_box.fadeOut(2000).delay(2000)
  $(this).parent('form').submit()
