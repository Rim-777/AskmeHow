require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let(:answer_of_another_user) do
    create(:answer,
           question: question,
           user: another_user,
           body: "Another Users' Answer Body")
  end

  before do
    sign_in(user)
    answer
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:request) do
        post :create,
             question_id: question,
             answer: attributes_for(:answer),
             format: :js
      end

      let(:channel) { "/question/#{question.id}/answers" }

      it 'save new answer in database depending with question' do
        expect { request }.to change(question.answers, :count).by(1)
      end

      it 'save new answer in database depending with user' do
        expect { request }.to change(user.answers, :count).by(1)
      end

      it 'render template Answers/create.js view' do
        request
        expect(response).to render_template :create
      end

      it_behaves_like 'Publishable' do
        let(:message) { :publish_answer }
      end
    end

    context 'with invalid attributes' do
      let(:invalid_request) do
        post :create,
             question_id: question,
             answer: attributes_for(:invalid_answer),
             format: :js
      end

      it 'does not save the answer' do
        expect { invalid_request }.to_not change(Answer, :count)
      end

      it 'render template Answers/create.js view' do
        invalid_request
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let(:update_request) do
      patch :update,
            question_id: question,
            id: answer,
            answer: { body: 'new body' },
            format: :js
    end

    context 'User is trying to update his own Answer' do
      it 'assigns the requested answer to @answer' do
        update_request
        expect(assigns(:answer)).to eq answer
      end

      it 'change answer body' do
        update_request
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'render template Answers/update.js view' do
        update_request
        expect(response).to render_template :update
      end
    end

    context 'User is trying to update his not Answer' do
      let(:anothers_request) do
        patch :update,
              question_id: question,
              id: answer_of_another_user,
              answer: { body: 'new body' },
              format: :js
      end
      it 'does not change answer attributes' do
        anothers_request
        answer_of_another_user.reload
        expect(answer_of_another_user.body).to eq "Another Users' Answer Body"
      end
    end
  end

  describe 'PATCH #select_best' do
    let!(:one_more_answer) do
      create(:answer, question: question, user: create(:user), is_best: false)
    end

    let(:request_with_old_attr) do
      patch :select_best,
            id: one_more_answer,
            question_id: one_more_answer.question,
            answer: attributes_for(:answer),
            format: :js
    end

    let(:request_with_new_attr) do
      patch :select_best,
            id: one_more_answer,
            question_id: one_more_answer.question,
            answer: { is_best: true },
            format: :js
    end

    context 'Question author is trying to mark best his question-answer' do
      it 'assigns the requested answer to @answer' do
        request_with_old_attr
        expect(assigns(:answer)).to eq one_more_answer
      end

      it "change answer's field 'is_best' " do
        request_with_new_attr
        one_more_answer.reload
        expect(one_more_answer.is_best?).to eq true
      end

      it 'render template Answers/select_best.js view' do
        request_with_old_attr
        expect(response).to render_template :select_best
      end
    end

    context 'Other user is trying to mark best an answer on his not question' do
      it "do not change answer's field 'is_best' " do
        sign_in(another_user)
        request_with_new_attr
        one_more_answer.reload
        expect(one_more_answer.is_best?).to eq false
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:destroy_request) do
      delete :destroy, question_id: question, id: answer, format: :js
    end
    context 'User is trying to remove his own answer ' do
      it "remove an user's answer" do
        expect { destroy_request }.to change(user.answers, :count).by(-1)
      end
    end

    context 'User is trying to remove his not answer' do
      it 'does not remove a question' do
        sign_in(another_user)
        expect { destroy_request }.to_not change(Answer, :count)
      end
    end

    it 'redirect to  index view' do
      destroy_request
      expect(response).to render_template :destroy
    end
  end
end
