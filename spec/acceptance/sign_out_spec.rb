require_relative 'acceptance_helper'

feature 'User sign out', %q{As authenticated user, I want to be able to sign out} do
  given(:user) {create(:user)}

  scenario 'the registered user is trying to sign out' do
   sign_in(user)
   page_behaves_like_authenticated
   click_on 'Log out'
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end
