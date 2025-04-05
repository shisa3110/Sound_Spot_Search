FactoryBot.define do
  factory :spot_tag do
    association :spot
    association :tag
  end
end
  