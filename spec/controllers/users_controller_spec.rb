require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:all_users) {create_list(:user, 3)}
  let(:user) {create(:user)}

  describe 'GET #index' do
    let(:request) {get :index}

    before do
      all_users
      request
    end

    it 'assigns the value for the variable @users as the users array' do
      expect(assigns(:users)).to match_array(all_users)
    end

    it 'renders the index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:request) {get :show, id: user}
    before do
      user
      request
    end

    it 'assigns the value for the variable @user as the required user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET/#edit' do
    let(:request) {get :edit, id: user}

    context 'the authenticated user and his/her profile' do
      before do
        sign_in(user)
        request
      end

      it 'assigns the value for the variable @user as the required user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the edit view' do
        expect(response).to render_template :edit
      end
    end
    context 'some unauthenticated user ' do
      it 'render edit view' do
        request
        expect(response).to_not render_template :edit
        expect(response).to render_template nil
      end
    end
  end

  describe 'PATCH #update' do
    let(:request) do
      patch :update, id: user, user: {first_name: 'John', last_name: 'Smith'}
    end

    context 'the authenticated user and his/her data' do
      before do
        sign_in(user)
        request
      end

      it 'assigns the value for the variable @user as the required user' do
        expect(assigns(:user)).to eq user
      end

      it "changes the user's first_name" do
        user.reload
        expect(user.first_name).to eq 'John'
      end

      it "changes the user's last_name" do
        user.reload
        expect(user.last_name).to eq 'Smith'
      end

      it 'renders the show view' do
        expect(response).to redirect_to user_path(user)
      end
    end

    context "the authenticated user and someone's else data" do
      before do
        sign_in(create(:user))
        request
      end

      it_behaves_like 'UnchangedUser'
    end

    context 'some unauthenticated user' do
      before {request}
      it_behaves_like 'UnchangedUser'
    end
  end
end
