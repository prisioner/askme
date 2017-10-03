FactoryGirl.define do
  factory :user do
    name 'Vasya'
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }

    after(:build) { |user| user.password = '12345678' if user.password.blank? }
  end

  factory :invalid_user do
    username nil
    email nil
  end
end
