require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let!(:question) { create(:question, user: create(:user)) }
  let!(:subscriber) { create(:user) }

  describe 'POST #create' do
    let(:subscribe_request) { post :create, question_id: question.id, format: :js }

    context 'Un-Authenticated User is trying subscribe for a question' do
      it 'do not add a subscription to question' do
        expect { subscribe_request }.to_not change(Subscription, :count)
      end
    end

    context 'the authenticated user is trying to subscribe the question ' do
      before { sign_in(subscriber) }

      it 'assigns the requested question to @question' do
        subscribe_request
        expect(assigns(:question)).to eq question
      end

      it 'adds a new subscription for the question' do
        expect { subscribe_request }.to change(question.subscriptions, :count).by(1)
      end

      it 'adds a new subscription for the subscriber' do
        expect { subscribe_request }.to change(subscriber.subscriptions, :count).by(1)
      end

      it 'renders the create template' do
        subscribe_request
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:unsubscribe_request) { delete :destroy, question_id: question.id, format: :js }

    context 'some unauthenticated User is trying unsubscribe from a question' do
      it 'do not delete a subscription to question' do
        expect { unsubscribe_request }.to_not change(Subscription, :count)
      end
    end

    context 'the authenticated user is trying to subscribe the question' do
      before { sign_in(subscriber) }
      let!(:subscription) { create(:subscription, user: subscriber, question: question) }

      it 'assigns the requested question to @question' do
        unsubscribe_request
        expect(assigns(:question)).to eq question
      end

      it 'deletes the subscription from the question' do
        expect { unsubscribe_request }.to change(question.subscriptions, :count).by(-1)
      end

      it 'deletes the subscription from the subscriber' do
        expect { unsubscribe_request }.to change(subscriber.subscriptions, :count).by(-1)
      end

      it 'renders the unsubscribe template' do
        unsubscribe_request
        expect(response).to render_template :destroy
      end
    end
  end
end
