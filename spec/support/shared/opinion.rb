shared_examples_for 'Opinion' do
  describe 'PATCH #positive' do
    let(:positive_request) do
      patch :positive,
            opinionable_id: opinionable_object.id,
            opinionable_type: opinionable_object.class,
            format: :json
    end

    context 'Some user is trying to say opinion for his not opinionable' do
      before { sign_in(some_user) }

      it 'assigns the requested opinionable_object to @opinionable' do
        positive_request
        expect(assigns(:opinionable)).to eq opinionable_object
      end

      it "Create positive opinion for user if  opinion don't exist" do
        expect { positive_request }.to change(some_user.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq 1
        expect(some_user.opinions.first.opinionable_id).to eq opinionable_object.id
      end

      it "create opinion for opinionable if opinion  don't exist" do
        expect { positive_request }.to change(opinionable_object.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq 1
        expect(some_user.opinions.first.user_id).to eq some_user.id
      end
    end

    context 'Some user is trying to change opinion for his not opinionable' do
      before { sign_in(some_user) }
      let!(:opinion) do
        create(:opinion,
               opinionable: opinionable_object,
               user: some_user,
               opinionable_type: opinionable_object.class,
               value: -1)
      end

      it 'delete old opinion for  user if new opinion is  different' do
        expect { positive_request }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for opinionable if opinion is different ' do
        expect { positive_request }.to change(opinionable_object.opinions, :count).by(-1)
      end
    end

    context 'Some user is trying to change  opinion of others opinionable' do
      let!(:one_more_opinion) do
        create(:opinion,
               opinionable: one_more_opinionable_object,
               user: some_user,
               opinionable_type: one_more_opinionable_object.class,
               value: -1)
      end

      let(:others_opinion_request) do
        patch :positive,
              opinionable_id: one_more_opinionable_object,
              opinionable_type: one_more_opinionable_object.class,
              format: :json
      end

      it 'note delete opinion of other user' do
        sign_in(one_more_some_user)
        expect { others_opinion_request }.to change(Opinion, :count).by(1)
        expect(one_more_opinion).to_not eq nil
        expect(one_more_opinion.value).to eq -1
      end
    end

    context 'Author is trying to say opinion for his opinionable' do
      before { sign_in(author_of_opinionable_object) }

      it 'note create new opinion' do
        expect { positive_request }.to_not change(Opinion, :count)
      end
      it 'render author_error template' do
        positive_request
        expect(response).to render_template :author_error
      end
    end

    context 'Un-authenticate user is trying to say opinion for opinionable' do
      it "don't create opinion for about opinionable" do
        expect { positive_request }.to_not change(Opinion, :count)
      end

      it 'render nothing' do
        positive_request
        expect(response).to render_template nil
      end
    end
  end

  describe 'PATCH #negative' do
    let(:negative_request) do
      patch :negative,
            opinionable_id: opinionable_object.id,
            opinionable_type: opinionable_object.class,
            format: :json
    end

    context 'Some user is trying to say opinion for his not opinionable' do
      before { sign_in(some_user) }

      it 'assigns the requested opinionable_object to @opinionable' do
        negative_request
        expect(assigns(:opinionable)).to eq opinionable_object
      end

      it 'Create new opinion from user if  opinion  do not exist' do
        expect { negative_request }.to change(some_user.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq -1
        expect(some_user.opinions.first.opinionable_id).to eq opinionable_object.id
      end

      it "Create new opinion for this opinionable if  opinion  don't exist" do
        expect { negative_request }.to change(opinionable_object.opinions, :count).by(1)
        expect(some_user.opinions.first.value).to eq -1
        expect(some_user.opinions.first.user_id).to eq some_user.id
      end
    end

    context 'Some user is trying to change opinion for his not opinionable' do
      before { sign_in(some_user) }
      let!(:opinion) do
        create(:opinion,
               opinionable: opinionable_object,
               user: some_user,
               opinionable_type: opinionable_object.class,
               value: 1)
      end
      it 'delete old opinion about opinionable if new is opinion  different ' do
        expect { negative_request }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for opinionable if new opinionis different ' do
        expect { negative_request }.to change(opinionable_object.opinions, :count).by(-1)
      end
    end

    context 'Some one else user is trying to change  opinion of other user' do
      let!(:one_more_opinion) do
        create(:opinion,
               opinionable: one_more_opinionable_object,
               user: some_user,
               opinionable_type: one_more_opinionable_object.class,
               value: 1)
      end

      let(:others_opinion_request) do
        patch :negative,
              opinionable_id: one_more_opinionable_object,
              opinionable_type: one_more_opinionable_object.class,
              format: :json
      end

      it 'not delete opinion of other user' do
        sign_in(one_more_some_user)
        expect { others_opinion_request }.to change(Opinion, :count).by(1)
        expect(one_more_opinion).to_not eq nil
        expect(one_more_opinion.value).to eq 1
      end
    end

    context 'Author of opinionable is trying  say opinion for his object' do
      it 'not create new opinion' do
        sign_in(author_of_opinionable_object)
        expect { negative_request }.to_not change(Opinion, :count)
      end
      it 'render nothing' do
        negative_request
        expect(response).to render_template nil
      end
    end

    context 'Un-authenticate user is trying say opinion for opinionable' do
      it "don't create opinion for user about opinionable" do
        expect { negative_request }.to_not change(Opinion, :count)
      end

      it 'render nothing' do
        negative_request
        expect(response).to render_template nil
      end
    end
  end
end
