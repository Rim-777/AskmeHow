function toggleEditAnswer(answerId, time) {
    $('#answer_crud_link_' + answerId).toggle(time);
    $('#answer_body_existed_' + answerId).toggle();
    $('#answer_edit_form_' + answerId).toggle();
}

function toggleEditQuestion() {
    $('.question_edit_link').toggle();
    $('.question_title_existed').toggle();
    $('.question_title_existed').next().toggle();
    $('.question_body_existed').toggle();
    $('form.edit_question').toggle();
    $('.question_rating').toggle();

}

function setActionToCommentField(entity) {
    entity_id = $(document.activeElement).data('commentableId');
    $('#' + entity + '_' + entity_id + '_comment_form_new').show();
    $('#' + entity + '_' + entity_id + '_comment_body_area')[0].focus();
    $('#' + entity + '_' + entity_id + '_comment_add_area').hide()
}

function sendCommentToUsers(data) {
    comment = $.parseJSON(data['comment']);
    entity = comment.commentable_type.toLowerCase();
    author_of_comment = $.parseJSON(data['author_of_comment']);
    entity_id = comment.commentable_id;
    if ($('#comment_' + comment.id)[0] == undefined) {
        $('#' + entity + '_' + entity_id + '_comments').append(JST["templates/comment"]({
            object: comment,
            author_of_comment: author_of_comment
        }));
        $('#' + entity + '_' + entity_id + '_comment_body_area').val('');
        $('#' + entity + '_' + entity_id + '_comment_form_new').hide();
        $('input[type="text"].' + entity + '_comment_add_area').show();

    }

}
function checkPasswordConfirmation() {
    var password_field = $('input[type="password"].sign_up_password_field').first().val();
    var password_confirmation = $('input[type="password"].sign_up_password_confitmation_field').first().val();

    if (password_field != password_confirmation){
        $('input[type="password"].sign_up_password_confitmation_field').get(0).setCustomValidity('Passwords is not match');
    } else{
        $('input[type="password"].sign_up_password_confitmation_field').get(0).setCustomValidity('');
    }


}




