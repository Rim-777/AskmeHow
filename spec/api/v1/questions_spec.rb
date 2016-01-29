require 'rails_helper'
include ApiMacros

describe 'question API' do
  describe 'GET /index' do
    un_authorized_request('/api/v1/questions')

    context 'authorized' do
      let(:user) { create (:user) }
      let(:access_token) { create(:access_token, resource_owner_id: user.id) }
      let!(:questions_list) { create_list(:question, 2, user: user) }
      let!(:question){questions_list.first}
      let!(:answer) { create(:answer, question_id: question.id, user: create(:user)) }
      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it_return_200_status

      it 'return list of question' do
        expect(response.body).to have_json_size(2)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("0/#{attr}")
        end
      end

      context 'answers' do

        it "included in question" do
          expect(response.body).to have_json_size(1).at_path("0/answers")
        end

        %w(id  body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("0/answers/0/#{attr}")
          end
        end
      end


    end


  end

end