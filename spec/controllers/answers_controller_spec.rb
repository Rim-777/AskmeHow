require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:another_user) { create(:user) }
  let(:question) { create(:question, user: @user) }
  let(:answer) { create(:answer, question: question, user: another_user) }
  let(:question_of_another_user) { create(:question, user: another_user) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'save new answer in database' do

        expect { post :create, question_id: question, answer: attributes_for(:answer)
        }.to change(question.answers, :count).by(1)
      end

      it 'redirect_to show view' do
        post :create, question_id: question, answer: attributes_for(:answer)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, question_id: question, answer: attributes_for(:invalid_answer)
        }.to_not change(Answer, :count)
      end

      it 're-render Question::show view' do
        post :create, question_id: question, answer: attributes_for(:invalid_answer)
        expect(response).to render_template 'questions/show'

      end
    end
  end

  describe 'DELETE # destroy' do
    sign_in_user


    context 'User is trying to remove  answer on his  question' do
      before { answer }
      it "remove an answers from answers on user's question" do
        expect { delete :destroy, question_id: question, id: answer }.to change(question.answers, :count).by(-1)
      end
    end


    context 'User is trying to remove his own answer ' do

      let(:answer) { create(:answer, question: question_of_another_user, user: @user) }

      before { answer }
      it "remove an user's answer" do
        expect { delete :destroy, question_id: question_of_another_user, id: answer }.to change(@user.answers, :count).by(-1)
      end
    end

    context "User is trying to remove his not answer, or answer on his not question" do
      let(:another_answer) { create(:answer, question: question_of_another_user, user: another_user) }
      before { another_answer }
      it 'Does not remove a question' do
        expect { delete :destroy, question_id: question_of_another_user, id: another_answer }.to_not change(Answer, :count)
      end

    end
    it 'redirect to  index view' do
      delete :destroy,  question_id: question, id: answer
      expect(response).to redirect_to question_path(question)
    end


  end

end
