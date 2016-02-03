require 'rails_helper'
include ApiMacros
describe 'answers API' do

  let_answers_spec_objects
  let(:http_method) { :get }

  describe 'GET /answers/index' do

    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let(:request) { get api_path, format: :json, access_token: access_token.token }
    let(:object_for_json_path) { "answers/0" }

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      before { request }

      it_return_200_status

      it "return array of answers with size 3" do
        expect(response.body).to have_json_size(3).at_path("answers")
      end

      it_behaves_like 'Api answers GET request'
    end

  end


  describe 'GET /answers/show' do
    let(:api_path) { "/api/v1/answers/#{answer.id}/" }
    let(:request) { get api_path, format: :json, access_token: access_token.token }
    let(:object_for_json_path) { "answer" }


    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      before { request }
      it_return_200_status
      it "return only 1  answer" do
        expect(response.body).to have_json_size(1)
      end
      it_behaves_like 'Api answers GET request'
    end


  end

  describe 'POST /create' do

    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }
    let!(:object_attributes) { attributes_for(:answer) }
    let(:object_for_json_path) { "answer" }
    let(:object_klass) { Answer }
    let(:post_request) { post api_path, answer: object_attributes, question_id: question.id, user: user,
                               format: :json, access_token: access_token.token }
    let(:request_with_invalid_object) { post api_path, answer: attributes_for(:invalid_answer),
                                             format: :json, access_token: access_token.token }

    it_behaves_like 'Invalid Api Authorization' do
      let(:http_method) { :post }
    end


    context 'authorized' do

      it 'creates a new answer for user' do
        expect { post_request }.to change(user.answers, :count).by(1)
      end

      it 'creates a new answer for question' do
        expect { post_request }.to change(question.answers, :count).by(1)
      end

      it_behaves_like 'Api Create'


    end
  end


end
