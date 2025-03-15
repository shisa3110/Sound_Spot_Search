FactoryBot.define do
  factory :instrument do
    title { Faker::Music.instrument }
    comment { Faker::Lorem.paragraph(sentence_count: 2) }
    instrument_image { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/test_image.png"), "image/png") }
    kind { Instrument.kinds.keys.sample } 
    association :user
  end
end