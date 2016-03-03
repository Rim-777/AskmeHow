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

    scenario 'user can attach file when hi ask question', js: true do
      fill_in 'answer_body_new', with: 'Test answer body'
      attach_file 'answer_attachments_attributes_0_file', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Create'
      within '.answers' do
        expect(page).to have_link 'rails_helper.rb', href: '/uploads/test/attachment/file/1/rails_helper.rb'

      end
    end

    scenario 'user is trying add few files to answer by few file_fields', js: true do

      within '#answer_form_new' do
        fill_in 'answer_body_new', with: 'Test answer body'

        expect(page).to have_link '[+]'
        click_on '[+]'

        add_inputs_type_files
      end

      click_on 'answer_create_button'

      within '.answers' do
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb'
      end
    end

    scenario 'user is trying remove one of few added file_fields from answer', js: true do

      within '#answer_form_new' do
        fill_in 'answer_body_new', with: 'Test answer body'

        expect(page).to have_link '[+]'
        click_on '[+]'
        add_inputs_type_files

        expect(page).to have_link '[-]'
        click_on '[-]', match: :first
      end
      click_on 'answer_create_button'

      within '.answers' do
        expect(page).to_not have_link 'spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb'
      end
    end
  end

end