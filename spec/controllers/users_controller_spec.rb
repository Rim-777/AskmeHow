require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:all_users) { create_list(:user, 3) }
  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:request) { get :index }

    before do
      all_users
      request
    end

    it 'assign value for @users as All Users array' do
      expect(assigns(:users)).to match_array(all_users)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:request) { get :show, id: user }
    before do
      user
      request
    end

    it 'assign value for @user as required user' do
      expect(assigns(:user)).to eq user

    end

    it 'render show view' do
      expect(response).to render_template :show
    end

  end

  describe 'GET/#edit' do
    let(:request) { get :edit, id: user }

    context 'authenticate user and it profile' do
      before do
        sign_in(user)
        request
      end

      it 'assign value for @user as required user' do
        expect(assigns(:user)).to eq user
      end

      it 'render edit view' do
        expect(response).to render_template :edit
      end


    end
    context 'un-authenticate user ' do

      it 'render edit view' do
        request
        expect(response).to_not render_template :edit
        expect(response).to render_template nil
      end

    end





  end

  describe 'PATCH #update' do
    let(:request) { patch :update, id: user, user: {first_name: 'John', last_name: 'Smith'} }

    context 'authenticate user and his data' do
      before do
        sign_in(user)
        request
      end

      it 'assign value for @user as required user' do
        expect(assigns(:user)).to eq user
      end

      it "change user's first_name" do
        user.reload
        expect(user.first_name).to eq 'John'
      end

      it "change user's last_name" do
        user.reload
        expect(user.last_name).to eq 'Smith'
      end

      it 'render show view' do
        expect(response).to redirect_to user_path(user)
      end

    end


    context 'authenticate user and his not data' do

      before do
        sign_in(create(:user))
        request
      end


      it "change not user's first_name" do
        user.reload
        expect(user.first_name).to_not eq 'John'
      end

      it "change not user's last_name" do
        user.reload
        expect(user.last_name).to_not eq 'Smith'
      end


    end

    context 'un-authenticate user' do

      before do
        request
      end

      it "change not user's first_name" do
        user.reload
        expect(user.first_name).to_not eq 'John'
      end

      it "change not user's last_name" do
        user.reload
        expect(user.last_name).to_not eq 'Smith'
      end
    end

  end

end
