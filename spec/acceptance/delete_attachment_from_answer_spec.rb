require_relative 'acceptance_helper'

feature 'Delete attachment from Answer', %q{
In order to remove  not actual my attachment
I want to be able to delete attachment from my Answer} do
  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:author_of_answer) { create(:user) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }
  given!(:answer_attachment) { create(:attachment, attachable: answer,
                                      file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb")) }
  given(:another_authenticated_user) { create(:user) }

  scenario 'Author of answer is trying delete his attachment', js: true do
    sign_in(author_of_answer)
    visit question_path(question)
    within "#answer_#{answer.id}" do
      expect(page).to have_selector "#attachment_#{answer_attachment.id}"
    end

    within "#attachment_#{answer_attachment.id}" do
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link "attachment_remove_link_#{answer_attachment.id}"
    end

    click_on "attachment_remove_link_#{answer_attachment.id}"
    sleep(1)
    expect(page).to_not have_link 'spec_helper.rb'
    expect(page).to_not have_link "attachment_remove_link_#{answer_attachment.id}"
  end

  scenario 'Some other user is trying delete his not attachment' do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within "#attachment_#{answer_attachment.id}" do
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to_not have_link "attachment_remove_link_#{answer_attachment.id}"
    end
  end

  scenario 'Un-authenticate user is trying delete any  attachment' do
    visit question_path(question)
    within "#attachment_#{answer_attachment.id}" do
      expect(page).to have_link 'rails_helper.rb'
      expect(page).to_not have_link "attachment_remove_link_#{answer_attachment.id}"
    end
  end
end
