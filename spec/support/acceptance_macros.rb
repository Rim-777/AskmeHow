module AcceptanceMacros

  def sign_in(user)
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on 'sign_in'
  end


  def can_see_question(with_answers: false)
    visit questions_path
    visit question_path(question)
    expect(current_path).to eq question_path(question)
    expect(page).to have_content question.title.upcase
    expect(page).to have_content question.body
    if with_answers
      question.answers.each { |answer| expect(page).to have_content answer.body }
    end
  end

  def can_see_full_question_list
    visit questions_path
    questions.each do |question|
      expect(page).to have_content question.title
    end
  end


def add_inputs_type_files
  all_inputs_type_file = all('input[type="file"]')
  all_inputs_type_file.first.set("#{Rails.root}/spec/spec_helper.rb")
  all_inputs_type_file.last.set("#{Rails.root}/spec/rails_helper.rb")
end

  def page_behaves_like_authenticated
    expect(page).to have_link "user_menu_link"
    click_on "user_menu_link"
    expect(page).to have_content "Log out"
    expect(page).to have_content "profile"
  end


  def page_has_search_area
    expect(page).to have_selector 'select#category'
    expect(page).to have_selector 'input[type="search"]#query'
    expect(page).to have_button 'search_button'
  end

end

