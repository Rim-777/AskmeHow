module ApiMacros

  def un_authorized_request(uri, post: false, get: false)

      it 'return 401 status if there is no access_token' do
        get uri, format: :json if get
        post uri, format: :json if post
        expect(response.status).to eq 401
      end

      it 'return 401 status if there is invalid access_token' do
        get uri, format: :json, access_token: '1234' if get
        post uri, format: :json, access_token: '1234' if post
        expect(response.status).to eq 401
      end

  end



  def it_return_200_status
  it 'return 200 status' do
    expect(response).to be_success
  end

  end

end