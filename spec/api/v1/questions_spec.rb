require 'rails_helper'
include ApiMacros

describe 'questions API' do
  let(:user) { create (:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let!(:questions_list) { create_list(:question, 2, user: user) }
  let!(:question) { questions_list.first }
  let!(:answer) { create(:answer, question_id: question.id, user: create(:user)) }


  describe 'GET /index' do
    un_authorized_request('/api/v1/questions')

    context 'authorized' do

      before { get '/api/v1/questions', format: :json, access_token: access_token.token }

      it_return_200_status

      it 'return list of question' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      it "question object contains short_title" do
        expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("questions/0/short_title")
      end

      context 'answers' do

        it "included in question" do
          expect(response.body).to have_json_size(1).at_path("questions/0/answers")
        end

        %w(id  body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end


    end


  end

  describe 'GET /show' do


    context 'un-authorized' do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}", format: :json
        expect(response.status).to eq 401
      end
      it 'return 401 status if there is invalid access_token' do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let!(:attachment_list) { create_list(:attachment, 2, attachable: question) }
      let!(:attachment) { attachment_list.first }
      let!(:comment_list) { create_list(:comment, 2, commentable_id: question.id,
                                        commentable_type: question.class.to_s, user: create(:user)) }
      let!(:comment) { comment_list.first }

      before { get "/api/v1/questions/#{question.id}/", format: :json, access_token: access_token.token }

      it_return_200_status

      it 'return question' do
        expect(response.body).to have_json_size(1)
      end

      %w(id title body created_at updated_at).each do |attr|
        it "question object contains #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("question/#{attr}")
        end
      end

      context 'answers' do

        it "included in question" do
          expect(response.body).to have_json_size(1).at_path("question/answers")
        end

        %w(id  body created_at updated_at).each do |attr|
          it "answer object contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("question/answers/0/#{attr}")
          end
        end
      end


      context 'attachments' do
        it "included in question" do
          expect(response.body).to have_json_size(2).at_path("question/attachments")
        end

        %w(id attachable_id attachable_type created_at updated_at ).each do |attr|
          it "attachments object contains #{attr}" do
            expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("question/attachments/0/#{attr}")
          end
        end

        it "attachment object contains file with url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("question/attachments/0/file/url")
        end


      end

      context 'comments' do
        it "included in question" do
          expect(response.body).to have_json_size(2).at_path("question/comments")
        end

        %w(id body commentable_id commentable_type created_at updated_at ).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("question/comments/0/#{attr}")
          end
        end
      end


    end

  end

  describe 'POST /create' do

    context 'un-authorized' do
      it 'return 401 status if there is no access_token' do
        post '/api/v1/questions', format: :json
        expect(response.status).to eq 401
      end
      it 'return 401 status if there is invalid access_token' do
        post '/api/v1/questions', format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end


    context 'authorized' do
      it 'returns 422 code' do
        post "/api/v1/questions/", question: attributes_for(:invalid_question), format: :json, access_token: access_token.token
        expect(response.status).to eq 422
      end

      it 'creates a new question' do
        expect { post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token }.to change(user.questions, :count).by(1)
      end

      it 'returns success code ' do
        post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token
        expect(response).to be_success
      end

      it 'return list of question' do
        post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token
        expect(response.body).to have_json_size(1)
      end


    end
  end

end