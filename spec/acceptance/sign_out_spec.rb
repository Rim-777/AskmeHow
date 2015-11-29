require_relative 'acceptance_helper'



feature 'User sign out', %q{As authenticate  User, I want be able to sign out} do

  given(:user) {create(:user)}

  scenario 'Registered user is trying to sign out' do

   sign_in(user)
    # save_and_open_page
   click_on 'Log out'

    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path

  end


end