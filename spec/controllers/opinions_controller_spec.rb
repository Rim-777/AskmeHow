require 'rails_helper'

describe OpinionsController do
  let(:author_of_opinionable_object) { create(:user) }
  let(:some_user) { create(:user) }
  let(:one_more_user) { create(:user) }
  let(:one_more_some_user) { create(:user) }
  let!(:opinionable_object) do
    create(:question,
           user: author_of_opinionable_object,
           title: 'OldTitleText',
           body: 'OldBodyText')
  end

  let!(:one_more_opinionable_object) do
    create(:question,
           user: one_more_user,
           title: 'OldTitleText',
           body: 'OldBodyText')
  end

  it_behaves_like 'Opinion'
end

describe OpinionsController do
  let(:author_of_opinionable_object) { create(:user) }
  let(:some_user) { create(:user) }
  let(:one_more_user) { create(:user) }
  let(:one_more_some_user) { create(:user) }
  let(:question) { create(:question, user: some_user) }
  let!(:opinionable_object) do
    create(:answer,
           question: question,
           user: author_of_opinionable_object,
           body: 'OldBodyText')
  end

  let!(:one_more_opinionable_object) do
    create(:answer,
           question: question,
           user: one_more_user,
           body: 'OldBodyText')
  end

  it_behaves_like 'Opinion'
end
