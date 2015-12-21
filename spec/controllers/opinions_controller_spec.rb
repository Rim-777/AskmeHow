require 'rails_helper'

RSpec.describe OpinionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:some_user) { create(:user) }
  let!(:question) { create(:question, user: user, title: 'OldTitleText', body: 'OldBodyText') }


  describe 'PATCH #say_positive' do
    before { sign_in(some_user) }
    context 'Some user is trying to say a new opinion for his not question' do

      it 'assigns the requested question to @opinionable' do
        patch :positive, opinionable_id: question.id, opinionable_type: question.class, format: :js
        expect(assigns(:opinionable)).to eq question
      end

      it 'Create new opinion for this user about question if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(some_user.opinions, :count).by(1)

      end

      it ' create new opinion  for this question from user if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(question.opinions, :count).by(1)
      end
    end

    context 'Some user is trying to change opinion for his not question' do

      let!(:opinion) { create(:opinion, opinionable: question, user: some_user, opinionable_type: question.class, value: -1) }
      it 'delete old opinion for this user about question if  opinion is existed and  new opinion is different ' do

        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for question if  opinion is existed and  new opinion is different ' do
        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(question.opinions, :count).by(-1)

      end
    end


    # it 'render temlate update wiev' do
    #   patch :update, id: question, question: attributes_for(:question), format: :js
    #   expect(response).to render_template :update
    # end
  end

  describe 'PATCH #say_negative' do
    before { sign_in(some_user) }
    context 'Some user is trying to say a new opinion for his not question' do

      it 'assigns the requested question to @opinionable' do
        patch :negative, opinionable_id: question.id, opinionable_type: question.class, format: :js
        expect(assigns(:opinionable)).to eq question
      end

      it 'Create new opinion for this user about question if  opinion  do not exist' do
        expect { patch :negative, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(some_user.opinions, :count).by(1)

      end

      it ' create new opinion  for this question from user if  opinion  do not exist' do
        expect { patch :negative, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(question.opinions, :count).by(1)
      end
    end

    context 'Some user is trying to change opinion for his not question' do

      let!(:opinion) { create(:opinion, opinionable: question, user: some_user, opinionable_type: question.class, value: 1) }
      it 'delete old opinion for this user about question if  opinion is existed and  new opinion is different ' do

        expect { patch :negative, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(some_user.opinions, :count).by(-1)
      end

      it 'delete old opinion for question if  opinion is existed and  new opinion is different ' do
        expect { patch :negative, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to change(question.opinions, :count).by(-1)

      end
    end


    # it 'render temlate update wiev' do
    #   patch :update, id: question, question: attributes_for(:question), format: :js
    #   expect(response).to render_template :update
    # end
  end

end

