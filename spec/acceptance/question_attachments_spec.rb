require_relative 'acceptance_helper'

feature 'Add files to Question', %q{
In order to illustrate some details  of my question
I want to be able to attach some files to my question} do

  given(:user) { create(:user) }
  before do
    sign_in(user)
    visit new_question_path
  end

  scenario 'user can attach file when hi ask question'  do
    fill_in 'question_title', with: 'Test question'
    fill_in 'question_body', with: 'Test question body'
    attach_file 'question_attachments_attributes_0_file', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'
    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
  end
end
