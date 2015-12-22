require 'rails_helper'

RSpec.describe OpinionsController, type: :controller do
  let(:author_of_question) { create(:user) }
  let(:some_user) { create(:user) }
  let!(:question) { create(:question, user: author_of_question, title: 'OldTitleText', body: 'OldBodyText') }
  let(:one_more_user) { create(:user) }
  let!(:one_more_question) { create(:question, user: one_more_user, title: 'OldTitleText', body: 'OldBodyText') }
  let(:one_more_some_user) { create(:user) }

  describe 'PATCH #positive' do

    context 'Some user is trying to say a new opinion for his not question' do
    before { sign_in(some_user) }

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
      before { sign_in(some_user) }

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


    # it 'render template update wiev' do
    #   patch :update, id: question, question: attributes_for(:question), format: :js
    #   expect(response).to render_template :update
    # end

    context 'Some one more user is trying to change  opinion of other user for his not question' do
      let!(:one_more_opinion) { create(:opinion, opinionable: one_more_question, user: some_user,
                                       opinionable_type: one_more_question.class, value: -1) }
      it 'note delete opinion of other user' do
        sign_in(one_more_some_user)
        expect { patch :positive, opinionable_id: one_more_question,
                       opinionable_type: one_more_question.class, format: :js}.to change(Opinion, :count).by(1)
        expect(one_more_opinion).to_not eq nil
        expect(one_more_opinion.value).to eq -1
      end
    end

    context 'Author of question is trying to say a new opinion for his question' do
      it 'note create new opinion' do
        sign_in(author_of_question)
        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to_not change(Opinion, :count)
      end
      it 'render nothing' do
        patch :positive, opinionable_id: question.id, opinionable_type: question.class, format: :js
        expect(response).to render_template nil
      end
    end

    context 'Some un-authenticate user is trying to say a new opinion for question' do

      it 'do not create new opinion for this user about question if  opinion  do not exist' do
        expect { patch :positive, opinionable_id: question.id,
                       opinionable_type: question.class, format: :js }.to_not change(Opinion, :count)
      end

      it 'render nothing' do
        patch :positive, opinionable_id: question.id, opinionable_type: question.class, format: :js
        expect(response).to render_template nil
      end
    end

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

