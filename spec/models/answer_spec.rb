require 'rails_helper'

RSpec.describe Answer, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"


  it {should validate_presence_of :body}
  it {should validate_presence_of :user_id}
  it {should validate_presence_of :question_id}
  it {should belong_to(:question)}
  it {should belong_to(:user)}
end
