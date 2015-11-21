module AcceptanceHelper

  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end


  def can_see_question(with_answers: false)
    visit questions_path
    visit question_path(question)
    expect(current_path).to eq question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    if with_answers
      expect(page).to have_content question.answers.first.title
      expect(page).to have_content question.answers.first.body
      expect(page).to have_content question.answers.second.title
      expect(page).to have_content question.answers.second.body
    end
  end
end

