require 'rails_helper'

# RSpec.describe OpinionsController, type: :controller do
  describe OpinionsController do
    let(:author_of_opinionable_object) { create(:user) }
    let(:some_user) { create(:user) }
    let(:one_more_user) { create(:user) }
    let(:one_more_some_user) { create(:user) }
    let!(:opinionable_object) { create(:question, user: author_of_opinionable_object, title: 'OldTitleText', body: 'OldBodyText') }
    let!(:one_more_opinionable_object) { create(:question, user: one_more_user, title: 'OldTitleText', body: 'OldBodyText') }


    it_behaves_like "Opinion"
  end

# end

