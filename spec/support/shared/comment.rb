shared_examples_for 'Comment' do
  describe 'POST #create' do
    describe 'Commentable comment' do


      describe 'Athenticate user' do
        before { sign_in(user) }


        context 'with valid attributes' do
          it 'assigns the requested commentable_object to @commentable' do
            post :create, comment_params, user_id: user.id, format: :js
            expect(assigns(:commentable)).to eq commentable_object
          end

          it 'save new comment in database depending with commentable_object' do
            expect { post :create, comment_params, format: :json }.to change(commentable_object.comments, :count).by(1)
          end

          it 'save new comment in database depending with user' do
            expect { post :create, comment_params, format: :js}.to change(user.comments, :count).by(1)
          end

        end

        # context 'with invalid attributes' do
        #   it 'do not save new comment in database depending with commentable_object' do
        #     expect { post :create, invalid_params, format: :js }.to_not change(Comment, :count)
        #   end
        #
        #
        # end
      end

    end
  end

end