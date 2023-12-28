FactoryBot.define do
  factory :user, aliases: [:owner] do
    first_name { 'Aron' }
    last_name { 'Summer' }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'password' }
  end
end
