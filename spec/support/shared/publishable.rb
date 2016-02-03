shared_examples_for 'Publishable'  do
  it 'publish object to pub-sub channel' do
    expect(subject).to receive(message)
    request
  end
  it 'publish with private pub' do
    expect(PrivatePub).to receive(:publish_to).with(channel, anything)
    request
  end
end

