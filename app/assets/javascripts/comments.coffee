$(document).on 'focus', 'input[type="text"].question_comment_add_area', () ->
  setActionToCommentField('question')
$(document).on 'focus', 'input[type="text"].answer_comment_add_area', () ->
  setActionToCommentField('answer')

ready = ->
#  $('input[type="text"].question_comment_add_area').bind 'focus', () ->
#    setActionToCommentField('question', this)
#
#  $('input[type="text"].answer_comment_add_area').bind 'focus', () ->
#    setActionToCommentField('answer', this)
  question_id = $('.question_existed_area').data('questionId')
  PrivatePub.subscribe "/question/" + question_id + "/comments", (data, channel) ->
    sendCommentToUsers('question', data)
  PrivatePub.subscribe "/question/" + question_id + "/answers/comments", (data, channel) ->
    sendCommentToUsers('answer', data)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)