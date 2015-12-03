$(document).ready ->
  setAnswerEditClick()
  setQuestionEditClick()

$(document).on page: change, ->
  setAnswerEditClick()
  setQuestionEditClick()
$(document).on page: load, ->
  setAnswerEditClick()
  setQuestionEditClick()
$(document).on page: update, ->
  setAnswerEditClick()
  setQuestionEditClick()

$(document).on page: partial - load, ->
  setAnswerEditClick()
  setQuestionEditClick()

