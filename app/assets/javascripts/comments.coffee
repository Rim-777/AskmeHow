# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on 'focus', 'input[type="text"].question_comment_add_area', (e) ->
  $('#comment_form_new').show()
  $('#question_comment_body_area')[0].focus()
  $(this).hide()


$ ->
  commentable_id = $('.question_comments').data('commentableId')
  PrivatePub.subscribe "/question/" + commentable_id + "/comments", (data, channel) ->
    comment = $.parseJSON(data['comment'])
    $('#question_' + commentable_id + '_comments').append('<div class="comment">' + comment.body + '</div>' + '<br>')
    $('#question_comment_body_area').val('');
    $('#comment_form_new').hide()
    $('input[type="text"].question_comment_add_area').show()



