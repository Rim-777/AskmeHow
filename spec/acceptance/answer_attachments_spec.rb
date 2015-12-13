class AnswerAttachmentsSpec
  require_relative 'acceptance_helper'

  feature 'Add files to Answer', %q{
In order to illustrate some details  of my answer
I want to be able to attach some files to my answer} do

    given(:user) { create(:user) }
    given(:question) { create(:question, user: user) }

    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'user can attach file when hi ask question' , js: true do
      fill_in 'answer_body_new', with: 'Test answer body'
      attach_file 'answer_attachments_attributes_0_file', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Create'
      within '.answers' do
      expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/1/rails_helper.rb'

      end
    end
  end

end