FactoryBot.define do
  factory :user do
    first_name { "Aron" }
    last_name { "Summer" }
    email { "tester@example.com" }
    password { "password" }
  end
end
