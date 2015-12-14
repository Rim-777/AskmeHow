require_relative 'acceptance_helper'

feature 'Delete attachment from Answer', %q{
In order to remove  not actual my attachment
I want to be able to delete attachment from my Answer} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given!(:author_of_answer) { create(:user) }
  given!(:answer) { create(:answer, question: question, user: author_of_answer) }
  given!(:attachment) { create(:attachment, attachable: answer,
                               file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb")) }
  given(:another_authenticated_user) { create(:user) }


  # scenario 'Author of answer is trying delete his attachment', js: true do
  #   sign_in(author_of_answer)
  #   visit question_path(question)
  #   within '.answer_attachments' do
  #     expect(page).to have_link 'spec_helper.rb'
  #     expect(page).to have_link 'delete'
  #
  #
  #     click_on 'delete'
  #     expect(page).to have_link 'spec_helper.rb'
  #     expect(page).to_not have_link 'delete'
  #   end
  #
  # end


  # scenario 'Some other user is trying delete his not attachment', js: true do
  #   sign_in(another_authenticated_user)
  #   visit question_path(question)
  #   within '.answer_attachments' do
  #     expect(page).to have_link 'spec_helper.rb'
  #     expect(page).to_not have_link 'delete'
  #   end
  # end
  #
  #
  # scenario 'Un-authenticate user is trying delete any  attachment' do
  #   visit question_path(question)
  #   within '.question_attachments' do
  #     expect(page).to have_link 'spec_helper.rb'
  #     expect(page).to_not have_link 'delete'
  #   end
  # end

end