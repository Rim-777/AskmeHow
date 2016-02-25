require 'rails_helper'
include ApiMacros

describe 'questions API' do
  let_questions_spec_objects
  let(:http_method){:get}

  describe 'GET /questions/index' do

    let(:api_path) {  "/api/v1/questions" }
    let(:request) { get api_path, format: :json, access_token: access_token.token }
    let(:object_for_json_path){"questions/1"}

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do
      before { request }

      it_return_200_status

      it 'return list of question' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end
      it_behaves_like "Api questions GET request"
    end
  end

  describe 'GET /show' do
    let(:api_path) {  "/api/v1/questions/#{question.id}" }
    let(:request) { get api_path, format: :json, access_token: access_token.token }
    let(:object_for_json_path){"question"}

    it_behaves_like 'Invalid Api Authorization'

    context 'authorized' do

      before { request}

      it_return_200_status

      it 'return question' do
        expect(response.body).to have_json_size(1)
      end

      it_behaves_like "Api questions GET request"

    end
  end

  describe 'POST /create' do

    let(:api_path) { "/api/v1/questions" }
    let(:object_for_json_path) { "question" }
    let!(:object_attributes) { attributes_for(:question) }
    let(:object_klass) { Question }
    let!(:post_request) { post api_path, question: object_attributes,
                               format: :json, access_token: access_token.token }
    let(:request_with_invalid_object) { post api_path, question: attributes_for(:invalid_question),
                                             format: :json, access_token: access_token.token }

    it_behaves_like 'Invalid Api Authorization' do
      let(:http_method) { :post }
    end

    context 'authorized' do
      it_behaves_like 'Api Create'

      it 'creates a new question for user' do
        expect { post api_path, question: object_attributes,
                      format: :json, access_token: access_token.token }.to change(user.questions, :count).by(1)
      end
      it_behaves_like 'Api Create'

    end
  end



end