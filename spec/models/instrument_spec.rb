require 'rails_helper'

RSpec.describe Instrument, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      instrument = build(:instrument)
        expect(instrument).to be_valid
        expect(instrument.errors).to be_empty
      end

    it "titleがない場合、バリデーションが機能してinvalidになるか" do
      instrument_without_title = build(:instrument, title: nil)
      expect(instrument_without_title).to be_invalid
      expect(instrument_without_title.errors[:title]).to eq ["投稿に失敗しました"]
    end

    it "commentがない場合、バリデーションが機能してinvalidになるか" do
      instrument_without_comment = build(:instrument, comment: nil)
      expect(instrument_without_comment).to be_invalid
      expect(instrument_without_comment.errors[:comment]).to eq ["投稿に失敗しました"]
    end

    it "instrument_imageがない場合、バリデーションが機能してinvalidになるか" do
      instrument_without_image = build(:instrument, instrument_image: nil)
      expect(instrument_without_image).to be_invalid
      expect(instrument_without_image[:instrument_image]).to eq ["投稿に失敗しました"]
    end

    it "titleの文字数が120文字より多い場合、バリデーションが機能してinvalidになるか" do
      instrument = build(:instrument, title: Faker::Lorem.characters(number: 121))
      expect(instrument).to be_invalid
      expect(instrument[:title]).to eq ["投稿に失敗しました"]
    end

    it "commentが65,535文字より多い場合、バリデーションが機能してinvalidになるか" do
      instrument = build(:instrument, comment: Faker::Lorem.characters(number: 65_536))
      expect(instrument).to be_invalid
      expect(instrument[:comment]).to eq ["投稿に失敗しました"]
    end

    it "titleの文字数が120文字以下の場合、バリデーションエラーが起きないか" do
      instrument = build(:instrument, title: Faker::Lorem.characters(number: 120))
      expect(instrument).to be_invalid
      expect(instrument[:title]).to eq ["投稿に失敗しました"]
    end

    it "commentが65,535文字以下の場合、バリデーションエラーが起きないか" do
      instrument = build(:instrument, comment: Faker::Lorem.characters(number: 65_535))
      expect(instrument).to be_invalid
      expect(instrument[:comment]).to eq ["投稿に失敗しました"]
    end
  end
end
