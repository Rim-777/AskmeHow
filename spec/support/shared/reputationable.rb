shared_examples_for 'Reputationable' do
  it 'should calculate user reputation after create' do
    expect(CalculateReputationJob).to receive(:perform_later).with(subject)
    subject.save!
  end

  it 'should not calculate user reputation after update' do
    subject.save!
    expect(CalculateReputationJob).to_not receive(:perform_later)
    subject.update(body: '123')
  end
end
