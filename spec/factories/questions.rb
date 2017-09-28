FactoryGirl.define do
  factory :question do
    text '#Привет, как #дела?'
    answer nil

    association :user

    factory :question_with_author do
      association :author, factory: :user
    end
  end

  factory :invalid_question do
    text nil
    answer nil

    association :user
  end
end
