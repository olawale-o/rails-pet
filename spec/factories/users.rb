FactoryBot.define do
  sequence(:email) { |n| "test#{n}@email.com" }
  sequence(:username) { |n| "test#{n}" }
  factory :user do
    email
    username
    password { 'password' }
  end
end
