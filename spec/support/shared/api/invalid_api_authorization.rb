shared_examples_for 'Invalid Api Authorization' do

  context 'un-authorized' do

    it 'return 401 status if there is no access_token' do
      do_request(http_method, api_path)
      expect(response.status).to eq 401
    end

    it 'return 401 status if there is invalid access_token' do
      do_request(http_method, api_path, access_token: '1234')
      expect(response.status).to eq 401
    end

  end


end