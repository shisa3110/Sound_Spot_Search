require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      bookmark = build(:bookmark)
      expect(bookmark).to be_valid
      expect(bookmark.errors).to be_empty
    end

    it '重複したuser_idが登録された場合、バリデーションが機能してinvalidエラーになるか' do
      user = create(:user)
      spot = create(:spot)
      create(:bookmark, user: user, spot: spot)
      bookmark_with_duplicated = build(:bookmark, user: user, spot: spot)
      expect(bookmark_with_duplicated).to be_invalid
    end

    it 'user_idが重複していない場合、バリデーションエラーが起きないか' do
      bookmark = create(:bookmark)
      bookmark_with_another = build(:bookmark, user_id: bookmark.user_id + 1)
      expect(bookmark_with_another).to be_valid
    end
  end
end
