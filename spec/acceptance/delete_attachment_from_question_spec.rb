require_relative 'acceptance_helper'

feature 'Delete attachment from Question', %q{
In order to remove my attachment
I want to be able to delete attachments from my Question} do
  given!(:author_of_question) { create(:user) }
  given!(:question) { create(:question, user: author_of_question) }
  given(:another_authenticated_user) { create(:user) }
  given!(:attachment) { create(:attachment, attachable: question,
                               file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb")) }

  scenario 'the author of the question is trying  to delete his/her attachment', js: true do
    sign_in(author_of_question)
    visit question_path(question)

    expect(page).to have_selector "#attachment_#{attachment.id}"
    within "#attachment_#{attachment.id}" do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to have_link "attachment_remove_link_#{attachment.id}"
    end

    click_on "attachment_remove_link_#{attachment.id}"
    sleep(1)

    expect(page).to_not have_link 'spec_helper.rb'
    expect(page).to_not have_link "attachment_remove_link_#{attachment.id}"
  end

  scenario "some user is trying delete someone's attachment", js: true do
    sign_in(another_authenticated_user)
    visit question_path(question)
    within '.question_attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link "attachment_remove_link_#{attachment.id}"
    end
  end

  scenario 'some unauthenticated user is trying to delete any attachment' do
    visit question_path(question)
    within '.question_attachments' do
      expect(page).to have_link 'spec_helper.rb'
      expect(page).to_not have_link "attachment_remove_link_#{attachment.id}"
    end
  end
end
