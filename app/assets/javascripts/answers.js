$(document).ready(function () {
    $('a.edit_answer').click(function (e) {
        e.preventDefault();
        var answerId = $(this).data('answerId');
        $('#answer_crud_link_' + answerId).toggle();
        $('#existed_answer_body_' + answerId).toggle();
        $('#edit_answer_' + answerId).toggle();
    })
});