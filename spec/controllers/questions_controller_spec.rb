require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user, title: 'OldTitleText', body: 'OldBodyText') }
  let(:another_user) { create(:user) }

  before { user }
  before { sign_in(user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, user: user) }

    before { get :index }

    it 'populates an array of all question' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do

    before { get :show, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'render show view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, id: question }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'render show view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save new question in database' do

        expect { post :create, question: attributes_for(:question)
        }.to change(Question, :count).by(1)

      end

      it 'redirect_to show view' do
        post :create, question: attributes_for(:question)
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, question: attributes_for(:invalid_question)
        }.to_not change(Question, :count)
      end

      it 're-render new view' do
        post :create, question: attributes_for(:invalid_question)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assigns the requested question to @question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, id: question, question: {title: 'new title', body: 'new body'}
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to the updated question' do
        patch :update, id: question, question: attributes_for(:question)
        expect(response).to redirect_to question
      end
    end


    context 'invalid attributes' do

      before { patch :update, id: question, question: {title: 'new title', body: nil} }
      it 'does not change question attributes' do
        expect(question.title).to eq 'OldTitleText'
        expect(question.body).to eq 'OldBodyText'
      end

      it 're-renders edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE # destroy' do
    before { another_user }
    before { question }

    context 'User is trying to delete his own question' do
      it 'remove a question' do
        expect { delete :destroy, id: question }.to change(Question, :count).by(-1)
      end
    end

    context 'User is trying to delete no his question' do
      it 'Does not remove a question' do
        sign_in(another_user)
        expect { delete :destroy, id: question }.to_not change(Question, :count)
      end
    end

    it 'redirect to  index view' do
      delete :destroy, id: question
      expect(response).to redirect_to questions_path
    end
  end
end
