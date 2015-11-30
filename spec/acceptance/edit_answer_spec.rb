require_relative 'acceptance_helper'

feature 'Edit Answer', %q{
In order to correct mistakes in my answer
I want to be able to edit my answers} do
  given(:author_of_question) { create(:user) }
  given(:author_of_answer) { create(:user) }
  given(:another_authenticated_user) { create(:user) }

  given(:question) { create(:question, user: author_of_question) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }


  scenario 'Un-Authenticate User is trying edit an Answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end
  describe 'Authenticate User' do
    before do
      sign_in(author_of_answer)
    end

    scenario 'Author of Answer can see link Edit' do


      visit question_path(question)
      within '.answers' do
        expect(page).to have_link 'edit'
      end
    end

    scenario 'Author of Answer is trying edit his Answer', js: true do

      visit question_path(question)
      click_on 'edit'
      within '.answers' do
        expect(page).to have_button 'Save'
      end


    end
    before { another_authenticated_user }
    scenario 'Authenticate User is trying edit his not Answer' do
      visit question_path(question)
      within '.answers' do
        expect(page).to_not have_link 'Edit'
      end
    end
  end
end