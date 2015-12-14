require_relative 'acceptance_helper'

feature 'Delete attachment from Question', %q{
In order to remove  not actual my attachment
I want to be able to delete attachment from my Question} do

  given!(:author_of_question) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }
  given(:another_authenticated_user) { create(:user) }
  given!(:attachment) { create(:attachment, attachable: question,
                               file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb")) }




    scenario 'Author of question is trying delete his attachment', js: true do
      sign_in(author_of_question)
      visit question_path(question)

      expect(page).to have_selector "#attachment_#{attachment.id}"
      within "#attachment_#{attachment.id}" do
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'delete file'
        click_on 'delete file'
      end

      within '.question_attachments' do
        expect(page).to_not have_link 'spec_helper.rb'
        expect(page).to_not have_link 'delete file'
      end

    end



  scenario 'Some user is trying delete his not attachment', js: true do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.question_attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link 'delete file'
    end
  end


  scenario 'Un-authenticate user is trying delete any  attachment' do
    visit question_path(question)
    within '.question_attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link 'delete file'
    end
  end

end