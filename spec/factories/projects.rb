FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "Project #{n}"}
    description { "A test project." }
    due_on { 1.week.from_now }
    association :owner # userへのaliasであることをmodelで記載する必要がある
  end
end
