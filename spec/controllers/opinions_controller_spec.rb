require 'rails_helper'

RSpec.describe OpinionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:some_user) { create(:user) }
  let!(:question) { create(:question, user: user, title: 'OldTitleText', body: 'OldBodyText') }
  let!(:opinion) {create(:opinion, opinionable: question, user: some_user, opinionable_type: question.class, value: - 1 )}

  describe 'PATCH #say_positive' do

    context 'Some user is trying chang opinion for his not question' do
        it 'assigns the requested question to @opinionable' do
          sign_in(some_user)
        patch :positive, id: opinion, opinionable_id: question.id, opinionable_type: question.class, format: :js
        expect(assigns(:opinionable)).to eq question
      end
      #
      # it 'changes question attributes' do
      #   patch :update, id: question, question: {title: 'new title', body: 'new body'}, format: :js
      #   question.reload
      #   expect(question.title).to eq 'new title'
      #   expect(question.body).to eq 'new body'
      # end
      #
      # it 'render temlate update wiev' do
      #   patch :update, id: question, question: attributes_for(:question), format: :js
      #   expect(response).to render_template :update
      # end
    end


    end
end
