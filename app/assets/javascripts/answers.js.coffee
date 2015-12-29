$(document).on 'click', 'a.answer_edit_link', (e) ->
  e.preventDefault()
  answerId = $(this).data('answerId')
  toggleEditAnswer(answerId)





