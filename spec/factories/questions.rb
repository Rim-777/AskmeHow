FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
    user
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end

  trait :has_answers do
    after(:create) do |question|
      create_list(:answer, 2, question: question, user_id: create(:user).id)
    end

  end
end
