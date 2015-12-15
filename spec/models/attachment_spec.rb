require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:attachable) }
    let!(:attachment_with_file) { create(:attachment, file:  Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb")) }

  describe 'method file_attached?' do
    let!(:attachment_without_file) { create(:attachment, file: nil) }

    it "check is file attached or not  and return false if file
        is not attached and true if file is attached" do
      expect(attachment_without_file.file_attached?).to eq false
      expect(attachment_with_file.file_attached?).to eq true
    end
  end

  describe 'method  file_name' do
    it "return name of attachments' file" do
      expect(attachment_with_file.file_name).to eq "spec_helper.rb"
    end
  end
end
