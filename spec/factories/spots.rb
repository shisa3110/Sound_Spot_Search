FactoryBot.define do
  factory :spot do
    name { "テストスポット" }
    category { 0 } 
    postal_code { "123-4567" }
    address { "東京都渋谷区1-1-1" }
    latitude { 35.6895 } 
    longitude { 139.6917 } 
    phone_number { "03-1234-5678" }
    web_site { "https://example.com" }
    room_charge { nil }
    place_id { "ChIJVXealLU_xkcRja_At0z9AGY" }
    opening_hours { "9:00-22:00" }
    spot_image { "https://example.com/image.jpg" }
  end
end