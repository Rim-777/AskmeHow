FactoryGirl.define do

  sequence :title do |n|
    "questionTitle#{n}"
  end

  sequence :body do |n|
    "textEntityBody#{n}"
  end

  factory :question do
    title
    body
    # user {create(:user)}
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
    user nil
  end

  trait :with_answers do
    after(:create) do |question|
      create_list(:answer, 2, question: question, user_id: create(:user).id)
    end

  end
end
