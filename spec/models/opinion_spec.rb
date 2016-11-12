require 'rails_helper'

RSpec.describe Opinion, type: :model do
  it { should validate_presence_of :value }
  it { should validate_presence_of :opinionable }
  it { should validate_presence_of :user }
  it { should belong_to(:opinionable) }
  it { should belong_to(:user) }
  it { should validate_uniqueness_of(:user_id).scoped_to([:opinionable_type, :opinionable_id]) }

  describe 'is_changed?' do
    let!(:user) {create(:user)}
    let!(:question) {create(:question, user:user)}
    let!(:opinion) { create(:opinion, value: 1, user:user, opinionable: question) }
    it "checks if the opinion changed  returns  true otherwise returns false" do
      expect(opinion.is_changed?(1)).to eq false
      expect(opinion.is_changed?(-1)).to eq true
    end
  end
end
