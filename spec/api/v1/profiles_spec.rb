require 'rails_helper'
include ApiMacros

describe 'Profile API' do
  let(:http_method) { :get }

  describe 'GET /me' do
    let(:api_path) { '/api/v1/profiles/me' }

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      let(:me) { create (:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get api_path, format: :json, access_token: access_token.token }

      it_return_200_status

      %w(email id created_at updated_at admin).each do |attr|
        it "contain #{attr}" do
          expect(response.body).to be_json_eql(me.send(attr.to_sym).to_json).at_path("#{attr.to_sym}")
        end
      end

      %w(password encrypted_password ).each do |attr|
        it "does not contain#{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end
  end

  describe 'GET /index' do
    let(:api_path) { '/api/v1/profiles' }

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      let!(:all_users) { create_list(:user, 5) }
      let!(:access_token) { create(:access_token, resource_owner_id: all_users.first.id) }

      before { get api_path, format: :json, access_token: access_token.token }

      it_return_200_status

      it "return the number of users equal to the number of users in database" do
        expect(response.body).to have_json_size(5).at_path('profiles')
      end

      it "contain all users" do
        expect(response.body).to be_json_eql(all_users.to_json).at_path('profiles')
      end
    end
  end

  describe 'GET /other_users' do
    let(:api_path) { '/api/v1/profiles/other_users' }

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      let!(:me) { create (:user), admin: true }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let!(:other_users) { create_list(:user, 4) }

      before { get api_path, format: :json, access_token: access_token.token }

      it_return_200_status

      it "return number of all users except one" do
        expect(response.body).to have_json_size(4).at_path('profiles')
      end

      it "contain all others users except me" do
        expect(response.body).to be_json_eql(other_users.to_json).at_path('profiles')
      end

      it "not contain me" do
        expect(response.body).to_not include_json(me.to_json)
      end
    end
  end
end
