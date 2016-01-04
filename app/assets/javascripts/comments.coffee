$(document).on 'focus', 'input[type="text"].question_comment_add_area', (e) ->
  question_id = $(this).data('commentableId')
  $('#question_' + question_id + '_comment_form_new').show()
  $('#question_' + question_id + '_comment_body_area')[0].focus()
  $(this).hide()


$(document).on 'focus', 'input[type="text"].answer_comment_add_area', (e) ->
  answer_id = $(this).data('commentableId')
  $('#answer_' + answer_id + '_comment_form_new').show()
  $('#answer_' + answer_id + '_comment_body_area')[0].focus()
  $(this).hide()

  PrivatePub.subscribe "/answer/" + answer_id + "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    author_of_comment = $.parseJSON(data['author_of_comment'])
    $('#answer_' + answer_id + '_comments').append(JST["templates/comment"]({object: comment , author_of_comment: author_of_comment}))
    $('#answer_' + answer_id + '_comment_body_area').val('');
    $('#answer_' + answer_id + '_comment_form_new').hide()
    $('input[type="text"].answer_comment_add_area').show()

ready = ->
  question_id = $('.question_existed_area').data('questionId')
  PrivatePub.subscribe "/question/" + question_id + "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    author_of_comment = $.parseJSON(data['author_of_comment'])
    $('#question_' + question_id + '_comments').append(JST["templates/comment"]({object: comment , author_of_comment: author_of_comment}))
    $('#question_' + question_id + '_comment_body_area').val('');
    $('#question_' + question_id + '_comment_form_new').hide()
    $('input[type="text"].question_comment_add_area').show()

  $.each $('.answer'), (i)->
    answer_id = $(this).data('answerId')
    PrivatePub.subscribe "/answer/" + answer_id + "/comments", (data, channel) ->
      comment = $.parseJSON(data['comment'])
      author_of_comment = $.parseJSON(data['author_of_comment'])
      $('#answer_' + answer_id + '_comments').append(JST["templates/comment"]({object: comment , author_of_comment: author_of_comment}))
      $('#answer_' + answer_id + '_comment_body_area').val('');
      $('#answer_' + answer_id + '_comment_form_new').hide()
      $('input[type="text"].answer_comment_add_area').show()



$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
