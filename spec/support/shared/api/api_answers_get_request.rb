shared_examples_for "Api answers GET request" do

  %w(id  body created_at ).each do |attr|
    it "contains answer attribute: #{attr}" do
      expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/#{attr}")
    end
  end

  context 'attachments' do
    it "is included in answer" do
      expect(response.body).to have_json_size(2).at_path("#{object_for_json_path}/attachments")
    end

    %w(id attachable_id attachable_type created_at updated_at ).each do |attr|
      it "contains attachment's attribute:  #{attr}" do
        expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/attachments/0/#{attr}")
      end
    end

    it "contains the attachment's file with url" do
      expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("#{object_for_json_path}/attachments/0/file/file/url")
    end

  end

  context 'comments' do
    it "is included in answers" do
      expect(response.body).to have_json_size(2).at_path("#{object_for_json_path}/comments")
    end

    %w(id body commentable_id commentable_type created_at updated_at).each do |attr|
      it "contains comment's attribute: #{attr}" do
        expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/comments/1/#{attr}")
      end
    end
  end
end