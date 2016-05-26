shared_examples_for 'Publishable' do
  it 'publish with private pub' do
    expect(PrivatePub).to receive(:publish_to).with(channel, anything)
    request
  end
end
