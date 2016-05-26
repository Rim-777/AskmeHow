$(document).on 'click', 'a.answer_edit_link', (e) ->
  e.preventDefault()
  answerId = $(this).data('answerId')
  toggleEditAnswer(answerId)

$ ->
  question_id = $('.question_existed_area').data('questionId')
  current_user_id = $('.question_existed_area').data('currentUserId')
  PrivatePub.subscribe '/question/' + question_id + '/answers', (data, channel) ->
    token = $('meta[name="csrf-token"]').attr('content')
    answer = $.parseJSON(data['answer'])
    if ($('#answer_' + answer.answer_id)[0]== undefined)
      $('.others_answers').prepend(JST["templates/answer"]({answer: answer, current_user_id: current_user_id, token: token }))
      $('.answers_count').html(answer.answers_count)
      $('#answer_body_new').val('') if answer.answer_author_id == current_user_id
