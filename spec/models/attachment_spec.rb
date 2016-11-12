require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should belong_to(:attachable) }
  it { should validate_presence_of :file }

  let!(:attachment_with_file) do
    create(:attachment, file: Rack::Test::UploadedFile.new("#{Rails.root}/spec/spec_helper.rb"))
  end

  describe 'file_name' do
    it "returns the name of attachments' file" do
      expect(attachment_with_file.file_name).to eq "spec_helper.rb"
    end
  end
end
