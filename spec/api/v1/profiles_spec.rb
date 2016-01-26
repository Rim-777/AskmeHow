require 'rails_helper'
include ApiMacros

describe 'Profile API' do
  describe 'Get/me' do

    un_authorized_request('/api/v1/profiles/me')

    context 'authorized' do
      let(:me) { create (:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', format: :json, access_token: access_token.token }
      it 'return 200 status' do

        expect(response).to be_success
      end

      %w(email id created_at updated_at admin).each do |attr|
        it "contain #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path(attr)
        end
      end


      %w(password encrypted_password ).each do |attr|
        it "does not contain#{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end

    end


  end

  describe 'Get/index' do

      un_authorized_request('/api/v1/profiles')

    context 'authorized' do
      let!(:me) { create (:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:other_users) { create_list(:user, 4) }

      before { get '/api/v1/profiles', format: :json, access_token: access_token.token }

      it 'return 200 status' do
        expect(response).to be_success
      end


      it "contain all others users except me" do

        expect(response.body).to have_json_size(4)
        other_users.each do |other_user|
          expect(response.body).to include_json(other_user.to_json)
        end

      end

      it "not contain me" do
        expect(response.body).to_not include_json(me.to_json)
      end

    end


  end

end