require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }




  describe 'POST #create' do
    describe 'Commentable comment' do
      let(:comment_params) do
        {comment: attributes_for(:comment),  commentable: 'questions',   question_id: question.id  }
      end

      let(:invalid_params) do
        {comment: attributes_for(:invalid_comment),  commentable: 'questions',   question_id: question.id  }
      end

      describe 'Athenticate user' do
        before { sign_in(user) }


        context 'with valid attributes' do
          it 'assigns the requested commentable_object to @commentable' do
            post :create, comment_params  , format: :json
            expect(assigns(:commentable)).to eq question
          end

          it 'save new comment in database depending with commentable_object' do
            expect { post :create, comment_params, format: :json }.to change(question.comments, :count).by(1)
          end

          it 'save new comment in database depending with user' do
            expect { post :create, comment_params, format: :json }.to change(user.comments, :count).by(1)
          end

          it 'render nothing' do
            post :create, comment_params
            expect(response).to render_template nil
          end

        end

        context 'with invalid attributes' do
          it 'do not save new comment in database depending with commentable_object' do
            expect { post :create, invalid_params, format: :json }.to_not change(question.comments, :count)
          end
        end
      end


      describe 'Un-athenticate user' do
        it 'do not save new comment in database depending with commentable_object' do
          expect { post :create, comment_params, format: :json }.to_not change(question.comments, :count)
        end
      end


      end
  end
end


#
# it 'save new comment in database depending with commentable_object' do
#
#   expect { post :create, commentable_id: question.id,  user_id: user.id, commentable_type: question.class}.to change(question.comments, :count).by(1)
# end
#
# it 'save new comments in database depending with user' do
#   expect { post :create, commentable_id: question.id, user_id: user.id}.to change(user.comments, :count).by(1)
# end

# it 'render template Answers/create.js view' do
#   post :create, question_id: question, answer: attributes_for(:answer), format: :js
#   expect(response).to render_template :create
# end

# context 'with invalid attributes' do
#   it 'does not save the answer' do
#     expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
#     }.to_not change(Answer, :count)
#   end
#
#   it 'render template Answers/create.js view' do
#     post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
#     expect(response).to render_template :create
#
#   end
# end


