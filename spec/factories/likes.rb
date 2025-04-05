FactoryBot.define do
  factory :like do
    association :user
    association :instrument
  end
end