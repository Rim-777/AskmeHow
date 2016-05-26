require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let!(:subscriber) { create(:user) }
  let(:question) do
    create(:question, user: user, title: 'OldTitleText', body: 'OldBodyText')
  end

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, user: user) }

    before do
      sign_in(user)
      get :index
    end

    it 'populates an array of all question' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before do
      sign_in(user)
      get :show, id: question
    end

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'assigns the new answer for question' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before do
      sign_in(user)
      get :new
    end

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before { sign_in(user) }

    context 'with valid attributes' do
      let(:request) { post :create, question: attributes_for(:question) }
      let(:channel) { '/questions' }

      it 'save new question in database' do
        expect { request }.to change(Question, :count).by(1)
      end

      it 'save new question in database depending with user' do
        expect { request }.to change(user.questions, :count).by(1)
      end

      it 'redirect_to show view' do
        request
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it_behaves_like 'Publishable' do
        let(:message) { :publish_question }
      end
    end

    context 'with invalid attributes' do
      let(:invalid_request) do
        post :create, question: attributes_for(:invalid_question)
      end

      it 'does not save the question' do
        expect { invalid_request }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    before { sign_in(user) }

    let(:patch_request) do
      patch :update,
            id: question,
            question: { title: 'new title', body: 'new body' },
            format: :js
    end

    let(:invalid_patch_request) do
      patch :update,
            id: question,
            question: { title: 'new title', body: nil },
            format: :js
    end

    context 'User is trying update his question' do
      before { patch_request }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'render template update wiev' do
        expect(response).to render_template :update
      end
    end

    context 'User is trying update his not question' do
      it 'does not change question attributes' do
        sign_in(another_user)
        patch_request
        question.reload
        expect(question.title).to eq 'OldTitleText'
        expect(question.body).to eq 'OldBodyText'
      end
    end

    context 'User is trying update his question with invalid attributes' do
      it 'does not change question attributes' do
        invalid_patch_request
        question.reload
        expect(question.title).to eq 'OldTitleText'
        expect(question.body).to eq 'OldBodyText'
      end
    end
  end

  describe 'DELETE # destroy' do
    let(:delete_request) { delete :destroy, id: question }
    before do
      sign_in(user)
      question
    end

    context 'User is trying to delete his own question' do
      it 'remove a question' do
        expect { delete_request }.to change(user.questions, :count).by(-1)
      end
    end

    context 'User is trying to delete  his not question' do
      it 'Does not remove a question' do
        sign_in(another_user)
        expect { delete_request }.to_not change(Question, :count)
      end
    end

    it 'redirect to  index view' do
      delete_request
      expect(response).to redirect_to questions_path
    end
  end
end
