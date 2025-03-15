require 'rails_helper'

RSpec.describe Spot, type: :model do
  let(:spot) { build(:spot) } 
  let!(:tag1) { create(:tag, name: 'タグ1') }
  let!(:tag2) { create(:tag, name: 'タグ2') }
  let(:review) { create(:review) }

  describe 'バリデーション' do
    it 'nameが必須' do
      spot.name = nil
      expect(spot).to be_invalid 
    end
  end

  describe 'save_with_tags' do
    it 'タグが正しく保存される' do
      spot.save

      spot.save_with_tags(tag_names: ['タグ1', 'タグ2'])
      spot.reload 

      expect(spot.tags.count).to eq(2) # 2つのタグが関連付けられていることを確認
      expect(spot.tags).to include(tag1, tag2) # タグが正しく関連付けられていることを確認
    end
  end

  describe 'tag_names' do
    it 'タグ名がカンマ区切りで返される' do
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