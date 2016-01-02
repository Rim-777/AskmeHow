$ ->
  PrivatePub.subscribe "/questions", (data, channel) ->
    question = $.parseJSON(data['question'])
    current_usser_id = $('.question_list').data('currentUserId')
    $('.question_list').append(JST["templates/question_data"]({question:question, current_user_id:current_usser_id }))


$(document).on 'click', 'a.question_edit_link', (e) ->
  e.preventDefault()
  toggleEditQuestion()

