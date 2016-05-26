shared_examples_for 'Comment' do
  describe 'POST #create' do
    describe 'Commentable comment' do
      describe 'Athenticate user' do
        before { sign_in(user) }

        context 'with valid attributes' do
          let(:request) { post :create, comment_params, format: :js }
          let(:channel) { "/question/#{commentable_object.class == Question ? commentable_object.id : commentable_object.question_id}/comments" }
          it 'assigns the requested commentable_object to @commentable' do
            post :create, comment_params, user_id: user.id, format: :js
            expect(assigns(:commentable)).to eq commentable_object
          end

          it 'save new comment in database depending with commentable_object' do
            expect { request }.to change(commentable_object.comments, :count).by(1)
          end

          it 'save new comment in database depending with user' do
            expect { request }.to change(user.comments, :count).by(1)
          end

          it_behaves_like 'Publishable' do
            let(:message) { :publish_comment }
          end
        end
      end
    end
  end
end
