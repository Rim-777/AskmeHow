require 'rails_helper'
include ApiMacros
describe 'answers API' do
  let(:user) { create (:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let!(:question) { create(:question, user: create(:user)) }
  let!(:answer_list) { create_list(:answer, 3, question: question, user: create(:user)) }
  let!(:answer) { answer_list.first }
  let!(:attachment_list) { create_list(:attachment, 2, attachable: answer) }
  let!(:attachment) { attachment_list.first }
  let!(:comment_list) { create_list(:comment, 2, commentable_id: answer.id,
                                    commentable_type: answer.class.to_s, user: create(:user)) }
  let!(:comment) { comment_list.first }

  describe 'GET /index' do

    context 'un-authorized' do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there is invalid access_token' do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end


    context 'authorized' do


      before do
        get "/api/v1/questions/#{question.id}/answers", format: :json, access_token: access_token.token
      end

      it_return_200_status

      it "return array of answers with size 3" do
        expect(response.body).to have_json_size(3).at_path("answers")
      end

      %w(id  body created_at updated_at).each do |attr|
        it "answer object contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answers/0/#{attr}")
        end
      end

      context 'attachments' do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("answers/0/attachments")
        end

        %w(id attachable_id attachable_type created_at updated_at ).each do |attr|
          it "attachments object contains #{attr}" do
            expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("answers/0/attachments/0/#{attr}")
          end
        end

        it "attachment object contains file with url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("answers/0/attachments/0/file/url")
        end

      end

      context 'comments' do
        it "included in answers" do
          expect(response.body).to have_json_size(2).at_path("answers/0/comments")
        end

        %w(id body commentable_id commentable_type created_at updated_at ).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("answers/0/comments/0/#{attr}")
          end
        end
      end

    end


  end

  describe 'GET /show' do

    context 'un-authorized' do
      it 'return 401 status if there is no access_token' do
        get "/api/v1/answers/#{answer.id}", format: :json
        expect(response.status).to eq 401
      end

      it 'return 401 status if there is invalid access_token' do
        get "/api/v1/answers/#{answer.id}", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end
    context 'authorized' do


      before do
        get "/api/v1/answers/#{answer.id}/", format: :json, access_token: access_token.token
      end

      it_return_200_status


      it "return only 1  answer" do
        expect(response.body).to have_json_size(1)
      end

      %w(id  body created_at updated_at).each do |attr|
        it "answer  contains #{attr}" do
          expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("answer/#{attr}")
        end
      end

      context 'attachments' do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("answer/attachments")
        end

        %w(id attachable_id attachable_type created_at updated_at ).each do |attr|
          it "attachments object contains #{attr}" do
            expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("answer/attachments/0/#{attr}")
          end
        end

        it "attachment object contains file with url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("answer/attachments/0/file/url")
        end

      end

      context 'comments' do
        it "included in answer" do
          expect(response.body).to have_json_size(2).at_path("answer/comments")
        end

        %w(id body commentable_id commentable_type created_at updated_at ).each do |attr|
          it "comment object contains #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("answer/comments/0/#{attr}")
          end
        end
      end

    end


  end

  describe 'POST /create' do

    context 'un-authorized' do
      it 'return 401 status if there is no access_token' do
        post  "/api/v1/questions/#{question.id}/answers", format: :json
        expect(response.status).to eq 401
      end
      it 'return 401 status if there is invalid access_token' do
        post "/api/v1/questions/#{question.id}/answers", format: :json, access_token: '1234'
        expect(response.status).to eq 401
      end
    end


    # context 'authorized' do
    #   it 'returns 422 code' do
    #     post "/api/v1/questions/", question: attributes_for(:invalid_question), format: :json, access_token: access_token.token
    #     expect(response.status).to eq 422
    #   end
    #
    #   it 'creates a new question' do
    #     expect { post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token }.to change(user.questions, :count).by(1)
    #   end
    #
    #   it 'returns success code ' do
    #     post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token
    #     expect(response).to be_success
    #   end
    #
    #   it 'return list of question' do
    #     post "/api/v1/questions/", question: attributes_for(:question), format: :json, access_token: access_token.token
    #     expect(response.body).to have_json_size(1)
    #   end
    #
    #
    # end
  end


end
