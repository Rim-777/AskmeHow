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

}




