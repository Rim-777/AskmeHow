require_relative 'acceptance_helper'

feature 'Delete attachment from Question', %q{
In order to remove  not actual my attachment
I want to be able to delete attachment from my Question} do

  given!(:author_of_question) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }
  given(:another_authenticated_user) { create(:user) }
  given!(:attachment) { create(:attachment, attachable: question,
                               file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb")) }


  describe 'Owner of Question and his attachment' do
    before do
      sign_in(author_of_question)
      visit question_path(question)
    end

    scenario 'Author of question is trying delete his attachment' do
      # question.reload
      within '.question_attachments' do
        expect(page).to have_link 'spec_helper.rb'
        within '.question_attachment_links' do
          expect(page).to have_link 'delete'
        end
      end

      click_on 'delete'
      # within '.question_attachments' do
      #   expect(page).to_not have_link 'spec_helper.rb'
      #   expect(page).to_not have_link 'delete'
      # end


    end

  end

  scenario 'Some usern is trying delete his not attachment' do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.question_attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link 'delete'
    end
  end

end