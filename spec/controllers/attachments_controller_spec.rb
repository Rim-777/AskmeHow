require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:answer) { create(:answer, question: question, user: user) }
  let!(:question_attachment) { create(:attachment, attachable: question) }
  let!(:another_user) { create(:user) }

  describe 'DELETE #destroy' do

    before { sign_in(user) }

    context 'User is trying to remove his own attachment ' do
      it "remove an user's answer" do

        expect { delete :destroy, question_id: question, id: question_attachment, format: :js }.to change(question.attachments, :count).by(-1)
      end
    end

    context "User is trying to remove his not answer" do
      it 'does not remove a question' do
        sign_in(another_user)
        expect { delete :destroy, question_id: question, id: question_attachment, format: :js }.to_not change(Attachment, :count)
      end
    end

    it 'render to  destroy view' do
      delete :destroy, question_id: question, id: question_attachment, format: :js
      expect(response).to render_template :destroy
    end

  end
end
