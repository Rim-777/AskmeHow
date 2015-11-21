FactoryGirl.define do
  factory :question do
    title "MyString"
    body "MyText"
  end

  factory :invalid_question, class: 'Question' do
    title nil
    body nil
  end

  trait :has_answers do
    after(:create) do |question|
      create_list(:answer, 2, question: question)
    end

  end
end
