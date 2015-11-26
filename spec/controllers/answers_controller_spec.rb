require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }


  before do
    sign_in(user)
    answer
  end

  describe 'POST #create' do

    context 'with valid attributes'  do

      it 'save new answer in database depending with question'  do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js
        }.to change(question.answers, :count).by(1)
      end

      it 'save new answer in database depending with user' do
        expect { post :create, question_id: question, answer: attributes_for(:answer), format: :js
        }.to change(user.answers, :count).by(1)
      end

      it 'render template Answers/create.js view' do
        post :create, question_id: question, answer: attributes_for(:answer), format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        }.to_not change(Answer, :count)
      end

      it 'render template Answers/create.js view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer), format: :js
        expect(response).to render_template :create

      end
    end
  end

  describe 'DELETE # destroy' do


    context 'User is trying to remove his own answer ' do
      it "remove an user's answer" do
        expect { delete :destroy, question_id: question, id: answer }.to change(user.answers, :count).by(-1)
      end
    end

    context "User is trying to remove his not answer" do
      it 'does not remove a question' do
        sign_in(another_user)
        expect { delete :destroy, question_id: question, id: answer }.to_not change(Answer, :count)
      end
    end

    it 'redirect to  index view' do
      delete :destroy, question_id: question, id: answer
      expect(response).to redirect_to question_path(question)
    end

  end

end
