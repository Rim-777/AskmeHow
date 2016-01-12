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
    $('form.edit_question').toggle()
    $('.question_rating').toggle()

}

function setActionToCommentField(entity,  self) {
    entity_id = $(self).data('commentableId');
    $('#' + entity + '_' + entity_id + '_comment_form_new').show();
    $('#' + entity + '_' + entity_id + '_comment_body_area')[0].focus();
    $(self).hide()
}




