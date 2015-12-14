require_relative 'acceptance_helper'

feature 'Delete attachment from Question', %q{
In order to remove  not actual my attachment
I want to be able to delete attachment from my Question} do

    given(:author_of_question) { create(:user) }
    given(:question) { create(:question, user: author_of_question) }
    given(:another_authenticated_user) { create(:user) }
    given(:attachment) { create(:attachment, attacable: question, file: 'some_file.txt') }

  describe 'Owner of Question and his attachment' do
      before do
        sign_in(author_of_question)
        visit question_path(question)
      end

    scenario 'Author of question is trying delete his attachment', js: true do
      expect(page).to have_link 'delete'
    end

  end

end