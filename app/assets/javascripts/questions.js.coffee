$(document).ready ->
  setQuestionEditClick()

  $("form.button_to").bind 'ajax:success', (e, data, status, xhr) ->
    response = $.parseJSON(xhr.responseText)
    $('.rating_result').html(response)

