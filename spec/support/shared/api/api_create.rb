shared_examples_for 'Api Create' do
  it 'returns 422 code' do
    request_with_invalid_object
    expect(response.status).to eq 422
  end

  before { post_request }

  it 'returns success code 201 ' do
    expect(response).to be_success
  end

  it 'return only 1 answer' do
    expect(response.body).to have_json_size(1)
  end


  it "contains correct answer attributes" do
    object_attributes.each do |key, value|
      expect(response.body).to be_json_eql(value.to_json).at_path("#{object_for_json_path}/#{key}")
    end
  end


  %w(id body created_at updated_at attachments user_id ).each do |attr|
    it "created question contains #{attr}" do
      expect(response.body).to be_json_eql(object_klass.last.send(attr.to_sym).to_json).at_path("#{object_for_json_path}/#{attr}")
    end
  end

end
