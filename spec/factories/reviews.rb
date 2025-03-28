FactoryBot.define do
  factory :review do
    association :user
    association :spot
    body { Faker::Lorem.paragraph(sentence_count: 3) }
  end
end
