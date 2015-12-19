require 'rails_helper'

RSpec.describe Opinion, type: :model do
  it { should validate_presence_of :value }
  it { should belong_to(:opinionable) }
  it { should belong_to(:user) }

  describe 'method is_changed?' do
    let!(:opinion) { create(:opinion, value: 1) }
    it "check if  opinion changed  return  true otherwise return false" do
      expect(opinion.is_changed?(1)).to eq false
      expect(opinion.is_changed?(-1)).to eq true

    end

  end
end
