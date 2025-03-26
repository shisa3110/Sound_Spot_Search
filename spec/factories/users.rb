FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    gender { 0 }
    provider { nil }
    uid { nil }
  end
end
