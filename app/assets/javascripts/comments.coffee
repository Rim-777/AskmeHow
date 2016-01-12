$(document).on 'focus', 'input[type="text"].question_comment_add_area', (e) ->
  setActionToCommentField('question', this)
$(document).on 'focus', 'input[type="text"].answer_comment_add_area', (e) ->
  setActionToCommentField('answer', this)

ready = ->
  question_id = $('.question_existed_area').data('questionId')
  PrivatePub.subscribe "/question/" + question_id + "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    author_of_comment = $.parseJSON(data['author_of_comment'])
    $('#question_' + question_id + '_comments').append(JST["templates/comment"]({object: comment , author_of_comment: author_of_comment}))
    $('#question_' + question_id + '_comment_body_area').val('');
    $('#question_' + question_id + '_comment_form_new').hide()
    $('input[type="text"].question_comment_add_area').show()


  PrivatePub.subscribe "/question/" + question_id + "/answers/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    author_of_comment = $.parseJSON(data['author_of_comment'])
    answer_id = comment.commentable_id
    $('#answer_' + answer_id + '_comments').append(JST["templates/comment"]({object: comment , author_of_comment: author_of_comment}))
    $('#answer_' + answer_id + '_comment_body_area').val('');
    $('#answer_' + answer_id + '_comment_form_new').hide()
    $('input[type="text"].answer_comment_add_area').show()



$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
