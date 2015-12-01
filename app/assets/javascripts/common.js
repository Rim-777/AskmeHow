function toggleEditAnswer(answerId, time) {
    $('#answer_crud_link_' + answerId).toggle(time);
    $('#existed_answer_body_' + answerId).toggle();
    $('#edit_answer_' + answerId).toggle();
}


function setAnswerEditClick() {
    $('a.edit_answer').click(function (e) {
        e.preventDefault();
        var answerId = $(this).data('answerId');
        toggleEditAnswer(answerId);
    })
}