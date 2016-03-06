$(document).on 'focus', 'input[type="text"].question_comment_add_area', () ->
  setActionToCommentField('question')
$(document).on 'focus', 'input[type="text"].answer_comment_add_area', () ->
  setActionToCommentField('answer')

ready = ->
  question_id = $('.question_existed_area').data('questionId')
  PrivatePub.subscribe "/question/" + question_id + "/comments", (data, channel) ->
    sendCommentToUsers(data)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)
