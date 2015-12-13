require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:attachable) }

  describe 'method file_attached?' do

    let!(:attachment) { create(:attachment) }

    it "check is file attached or not  and return false if file is not attached" do
      expect(attachment.file_attached?).to eq false
    end
  end



end
