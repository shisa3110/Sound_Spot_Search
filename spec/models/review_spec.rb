require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      review = build(:review)
      expect(review).to be_valid
      expect(review.errors).to be_empty
    end

    it 'bodyがない場合、バリデーションが機能してinvalidエラーになるか' do
      review_without_body = build(:review, body: nil)
      expect(review_without_body).to be_invalid
      expect(review_without_body.errors[:body]).to eq ["が入力されていません。"]
    end

    it "bodyが65,535文字より多い場合、バリデーションが機能してinvalidになるか" do
      review = build(:review, body:Faker::Lorem.characters(number: 65_536))
      expect(review).to be_invalid
    end

    it "commentが65,535文字以下の場合、バリデーションエラーが起きないか" do
      review = build(:review, body: Faker::Lorem.characters(number: 65_535))
      expect(review).to be_valid
    end
  end
end

