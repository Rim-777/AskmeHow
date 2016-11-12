shared_examples_for 'UnchangedUser' do
  it "doesn't change the user's first_name" do
    user.reload
    expect(user.first_name).to_not eq 'John'
  end

  it "doesn't change the user's last_name" do
    user.reload
    expect(user.last_name).to_not eq 'Smith'
  end
end
