json.answer_id @answer.id
json.answer_rating @answer.opinions.rating
json.answer_body @answer.body
json.answer_attachments @answer.attachments
json.answer_author_name @answer.user.email
json.answer_author_id @answer.user_id
json.answer_question_author_id @answer.question.user_id
