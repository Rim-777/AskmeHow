shared_examples_for 'Opinion' do
    describe 'PATCH #positive' do
    context 'Some user is trying to say a new opinion for his not opinionable_object' do
      before { sign_in(some_user) }

      it 'assigns the requested opinionable_object to @opinionable' do
        patch :positive, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(assigns(:opinionable)).to eq opinionable_object
      end

      it 'Create new positive opinion for this user about opinionable_object if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(some_user.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq 1
        expect(some_user.opinions.first.opinionable_id).to eq opinionable_object.id

      end

      it ' create new opinion  for this opinionable_object from user if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(opinionable_object.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq 1
        expect(some_user.opinions.first.user_id).to eq some_user.id
      end
    end

    context 'Some user is trying to change opinion for his not opinionable_object' do
      before { sign_in(some_user) }

      let!(:opinion) { create(:opinion, opinionable: opinionable_object, user: some_user, opinionable_type: opinionable_object.class, value: -1) }
      it 'delete old opinion for this user about opinionable_object if  opinion is existed and  new opinion is different ' do

        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for opinionable_object if  opinion is existed and  new opinion is different ' do
        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(opinionable_object.opinions, :count).by(-1)

      end
    end


    # it 'render template update wiev' do
    #   patch :update, id: opinionable_object, opinionable_object: attributes_for(:opinionable_object), format: :js
    #   expect(response).to render_template :update
    # end

    context 'Some one else user is trying to change  opinion of other user opinionable_object' do
      let!(:one_more_opinion) { create(:opinion, opinionable: one_more_opinionable_object, user: some_user,
                                       opinionable_type: one_more_opinionable_object.class, value: -1) }
      it 'note delete opinion of other user' do
        sign_in(one_more_some_user)
        expect { patch :positive, opinionable_id: one_more_opinionable_object,
                       opinionable_type: one_more_opinionable_object.class, format: :js}.to change(Opinion, :count).by(1)
        expect(one_more_opinion).to_not eq nil
        expect(one_more_opinion.value).to eq -1
      end
    end

    context 'Author of opinionable_object is trying to say a new opinion for his opinionable_object' do
      it 'note create new opinion' do
        sign_in(author_of_opinionable_object)
        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to_not change(Opinion, :count)
      end
      it 'render nothing' do
        patch :positive, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(response).to render_template nil
      end
    end

    context 'Some un-authenticate user is trying to say a new opinion for some opinionable_object' do

      it 'do not create new opinion for this user about opinionable_object if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to_not change(Opinion, :count)
      end

      it 'render nothing' do
        patch :positive, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(response).to render_template nil
      end
    end

  end

  describe 'PATCH #negative' do
    context 'Some user is trying to say a new opinion for his not opinionable_object' do
      before { sign_in(some_user) }

      it 'assigns the requested opinionable_object to @opinionable' do
        patch :negative, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(assigns(:opinionable)).to eq opinionable_object
      end

      it 'Create new opinion for this user about opinionable_object if  opinion  do not exist' do
        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(some_user.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq -1
        expect(some_user.opinions.first.opinionable_id).to eq opinionable_object.id

      end

      it 'Create new opinion  for this opinionable_object from user if  opinion  do not exist' do
        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(opinionable_object.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq -1
        expect(some_user.opinions.first.user_id).to eq some_user.id
      end
    end

    context 'Some user is trying to change opinion for his not opinionable_object' do
      before { sign_in(some_user) }
      let!(:opinion) { create(:opinion, opinionable: opinionable_object, user: some_user, opinionable_type: opinionable_object.class, value: 1) }
      it 'delete old opinion for this user about opinionable_object if  opinion is existed and new opinion is different ' do

        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for opinionable_object if  opinion is existed and  new opinion is different ' do
        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to change(opinionable_object.opinions, :count).by(-1)

      end
    end


    # it 'render temlate update wiev' do
    #   patch :update, id: opinionable_object, opinionable_object: attributes_for(:opinionable_object), format: :js
    #   expect(response).to render_template :update
    # end
    context 'Some one else user is trying to change  opinion of other user' do
      let!(:one_more_opinion) { create(:opinion, opinionable: one_more_opinionable_object, user: some_user,
                                       opinionable_type: one_more_opinionable_object.class, value: 1) }
      it 'not delete opinion of other user' do
        sign_in(one_more_some_user)
        expect { patch :negative, opinionable_id: one_more_opinionable_object,
                       opinionable_type: one_more_opinionable_object.class, format: :js}.to change(Opinion, :count).by(1)
        expect(one_more_opinion).to_not eq nil
        expect(one_more_opinion.value).to eq 1
      end
    end

    context 'Author of opinionable_object is trying to say a new opinion for his opinionable_object' do
      it 'not create new opinion' do
        sign_in(author_of_opinionable_object)
        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to_not change(Opinion, :count)
      end
      it 'render nothing' do
        patch :negative, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(response).to render_template nil
      end
    end

    context 'Some un-authenticate user is trying to say a new opinion for some opinionable_object' do

      it 'do not create new opinion for this user about opinionable_object if  opinion  do not exist' do
        expect { patch :negative, opinionable_id: opinionable_object.id,
                       opinionable_type: opinionable_object.class, format: :js }.to_not change(Opinion, :count)
      end

      it 'render nothing' do
        patch :negative, opinionable_id: opinionable_object.id, opinionable_type: opinionable_object.class, format: :js
        expect(response).to render_template nil
      end
    end

  end

end