function toggleEditAnswer(answerId, time) {
    $('#answer_crud_link_' + answerId).toggle(time);
    $('#existed_answer_body_' + answerId).toggle();
    $('#edit_answer_' + answerId).toggle();
}

function toggleEditQuestion(questionId, time) {
    $('#question_crud_link_' + questionId).toggle(time);
    $('#question_title_existed_'+ questionId).toggle();
    $('#question_body_existed_' + questionId).toggle();
    $('#question_form_edit_' + questionId).toggle()

}

function setAnswerEditClick() {
    $('a.edit_answer').click(function (e) {
        e.preventDefault();
        var answerId = $(this).data('answerId');
        toggleEditAnswer(answerId);
    })
}


function setQuestionEditClick(){
    $('a.question_edit_link').click(function (e) {
        e.preventDefault();
        var questionId = $(this).data('questionId');
       toggleEditQuestion(questionId)
    })
}
