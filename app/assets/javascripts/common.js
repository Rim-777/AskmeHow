function toggleEditAnswer(answerId, time) {
    $('#answer_crud_link_' + answerId).toggle(time);
    $('#answer_body_existed_' + answerId).toggle();
    $('#answer_edit_form_' + answerId).toggle();
}


function setAnswerEditClick() {
    $('a.answer_edit_link').click(function (e) {
        e.preventDefault();
        var answerId = $(this).data('answerId');
        toggleEditAnswer(answerId);
    })
}

function toggleEditQuestion(questionId, time) {
    $('#question_crud_link_' + questionId).toggle(time);
    $('#question_title_existed_'+ questionId).toggle();
    $('#question_body_existed_' + questionId).toggle();
    $('#question_form_edit_' + questionId).toggle()

}

function setQuestionEditClick(){
    $('a.question_edit_link').click(function (e) {
        e.preventDefault();
        var questionId = $(this).data('questionId');
       toggleEditQuestion(questionId)
    })
}

function setToggleOnAnswerEditLink(answerId){
    $('#answer_edit_link_'+ answerId ).click(function (e) {
        e.preventDefault();
        toggleEditAnswer(answerId);
    });

}



