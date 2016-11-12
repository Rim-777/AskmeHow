shared_examples_for "Api questions GET request" do

  %w(id title body created_at ).each do |attr|
    it "question object contains #{attr}" do
      expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/#{attr}")
    end
  end

  it "contains a short title" do
    expect(response.body).to be_json_eql(question.title.truncate(10).to_json).at_path("#{object_for_json_path}/short_title")
  end

  context 'answers' do

    it 'is included in the question' do
      expect(response.body).to have_json_size(1).at_path("#{object_for_json_path}/answers")
    end

    %w(id  body created_at updated_at).each do |attr|
      it "answer object contains #{attr}" do
        expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/answers/0/#{attr}")
      end
    end
  end

  context 'attachments' do
    it "included in question" do
      expect(response.body).to have_json_size(2).at_path("#{object_for_json_path}/attachments")
    end

    %w(id attachable_id attachable_type created_at updated_at ).each do |attr|
      it "attachments object contains #{attr}" do
        expect(response.body).to be_json_eql(attachment.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/attachments/0/#{attr}")
      end
    end

    it 'contains file with url' do
      expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("#{object_for_json_path}/attachments/0/file/file/url")
    end
  end

  context 'comments' do

    it 'is included in the question' do
      expect(response.body).to have_json_size(2).at_path("#{object_for_json_path}/comments")
    end

    %w(id body commentable_id commentable_type created_at updated_at ).each do |attr|
      it "contains the comment's attribute #{attr}" do
        expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/comments/1/#{attr}")
      end
    end
  end

end