FactoryBot.define do
  factory :spot do
    name { Faker::Address.street_name }
    category { Faker::Number.between(from: 0, to: 2) }
    postal_code { Faker::Address.zip_code }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    phone_number { Faker::PhoneNumber.phone_number }
    web_site { Faker::Internet.url }
    place_id { Faker::Alphanumeric.alpha(number: 20) }
    opening_hours { "9:00-22:00" } 
    spot_image { Faker::Internet.url(host: 'example.com') }
  end
end