require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot) { build(:spot) }
  let!(:tag1) { create(:tag, name: 'タグ1') }
  let!(:tag2) { create(:tag, name: 'タグ2') }
  let(:review) { create(:review) }

  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      spot = build(:spot)
      expect(spot).to be_valid
      expect(spot.errors).to be_empty
    end

    it 'nameがない場合、バリデーションが機能してinvalidエラーになるか' do
      spot_without_name = build(:spot, name: nil)
      expect(spot_without_name).to be_invalid
      expect(spot_without_name.errors[:name]).to eq ["が入力されていません。"]
    end
  end

  describe 'save_with_tagsメソッド' do
    it 'タグが正しく保存されるか' do
      spot.save
      spot.save_with_tags(tag_names: [ 'タグ1', 'タグ2' ])
      spot.reload
      expect(spot.tags.count).to eq(2) # 2つのタグが関連付けられていることを確認
      expect(spot.tags).to include(tag1, tag2) # タグが正しく関連付けられていることを確認
    end
  end

  describe 'tag_namesメソッド' do
    it 'タグ名がカンマ区切りで返されるか' do
      spot = create(:spot)
      spot.tags.create(name: 'タグ1')
      spot.tags.create(name: 'タグ2')
      expect(spot.tag_names).to eq 'タグ1,タグ2'
    end
  end

  describe 'associations' do
    it 'bookmarksとの関連' do
      spot = create(:spot)
      bookmark = create(:bookmark, spot: spot)
      expect(spot.bookmarks.count).to eq 1
    end

    it 'reviewsとの関連' do
      spot = create(:spot)
      review = create(:review, spot: spot)
      expect(spot.reviews.count).to eq 1
    end
  end
end
