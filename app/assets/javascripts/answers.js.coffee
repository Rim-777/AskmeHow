$(document).on 'click', 'a.answer_edit_link', (e) ->
  e.preventDefault()
  answerId = $(this).data('answerId')
  toggleEditAnswer(answerId)

$ ->
  question_id = $('#answer_body_new').data('questionId')
  current_user_id = $('.question_existed_area').data('currentUserId')
  PrivatePub.subscribe '/question/' + question_id + '/answers', (data, channel) ->
#    answer = $.parseJSON(data['answer'])
#    $('.others_answers').append(JST["templates/answer"]({answer: answer, current_user_id: current_user_id }))
#    $('#answer_body_new').val('') if answer.answer_author_id == current_user_id

