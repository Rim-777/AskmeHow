require_relative 'acceptance_helper'

feature 'Add files to Question', %q{
In order to illustrate some details  of my question
I want to be able to attach some files to my question} do

  given(:author_of_question) { create(:user) }
  before do
    sign_in(author_of_question)
    visit new_question_path
  end

  scenario 'user can attach file when hi ask question'  do
    fill_in 'question_title', with: 'Test question'
    fill_in 'question_body', with: 'Test question body'
    attach_file 'question_attachments_attributes_0_file', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end

  scenario 'user is trying add few files to question', js: true do

    within '#question_form_new' do
      fill_in 'question_title', with: 'Question Title Test'
      fill_in 'question_body', with: 'Question Body Test'
    end

    within '.new_question' do
      expect(page).to have_link '[+]'
      click_on '[+]'
      click_on '[+]'

      all_inputs_type_file = all('input[type="file"]')
      # sleep(1)
      all_inputs_type_file[0].set("#{Rails.root}/spec/spec_helper.rb")
      all_inputs_type_file[1].set("#{Rails.root}/spec/rails_helper.rb")
    end
        click_on 'question_create_button'

      within '.question_existed_area' do
        expect(page).to have_link 'spec_helper.rb'
        expect(page).to have_link 'rails_helper.rb'
      end
  end

end
