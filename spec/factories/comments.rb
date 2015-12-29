FactoryGirl.define do
  factory :comment do
    body 'some comment body'
  end

  factory :invalid_comment, class: 'Comment' do
    body nil
  end
end
