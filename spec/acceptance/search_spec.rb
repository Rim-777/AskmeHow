require_relative 'acceptance_helper'
feature 'User searching', %q{
To find question, answer or comment  I want be able to
search it} do
  given!(:user){create(:user)}
  given!(:question) { create(:question, user: create(:user), title: 'Searching Title', body: 'Searching Body') }
  given!(:answer) { create(:answer, question: question, user: create(:user), body: 'Searching Body') }
  given!(:question_comment) { create(:comment, commentable: question, commentable_type: 'Qutdtion', user: create(:user), body: 'Searching Body') }
  given!(:answer_comment) { create(:comment, commentable: answer, commentable_type: 'Qutdtion', user: create(:user), body: 'Searching Body') }
  given!(:query) { 'Searching Body' }

  before {index}
  before { visit questions_path }

  scenario 'user can search question', js: true do
    page_has_search_area

    select('Question', from: 'category')
    click_on 'search_button'

    expect(current_path).to eq questions_path

    within '.found_list' do
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end

  end

  scenario 'user can search answer', js: true do
    page_has_search_area
    select('Answer', from: 'category')
    click_on 'search_button'
    expect(current_path).to eq questions_path

    within '.found_list' do
      expect(page).to have_content question.title
      expect(page).to have_content answer.body
    end
  end

  scenario 'user can search comments', js: true do
    page_has_search_area
    select('Comment', from: 'category')
    click_on 'search_button'
    expect(current_path).to eq questions_path

    within '.found_list' do
      expect(page).to have_content question_comment.body
      expect(page).to have_content answer_comment.body
    end
  end

  scenario 'user can search by users', js: true do
    page_has_search_area
    select('User', from: 'category')
    click_on 'search_button'

    expect(current_path).to eq questions_path
    within '.found_list' do
      expect(page).to have_content user.email
      expect(page).to have_content question.user.email
      expect(page).to have_content answer.user.email
      expect(page).to have_content question_comment.user.email
      expect(page).to have_content answer_comment.user.email

    end
  end

  scenario 'user can search by entered string', js: true do
    page_has_search_area
    select('All categories', from: 'category')

    fill_in 'query', with: query
    click_on 'search_button'

    expect(current_path).to eq questions_path

    within '.found_list' do
      expect(page).to have_content question.title
      expect(page).to have_content answer.body
      expect(page).to have_content question_comment.body
      expect(page).to have_content answer_comment.body
    end
  end


end