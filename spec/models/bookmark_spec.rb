require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      bookmark = build(:bookmark)
      expect(bookmark).to be_valid
      expect(bookmark.errors).to be_empty
    end

    it '重複したuser_idが登録された場合、バリデーションが機能してinvalidエラーになるか' do
      bookmark = create(:bookmark)
      bookmark_with_duplicated = build(:bookmark, user_id: bookmark.user_id)
      expect(bookmark_with_duplicated_user_id).to be_invalid
    end

    it 'user_idが重複していない場合、バリデーションエラーが起きないか'
      bookmark = create(:bookmark)
      bookmark_with_another = create(:bookmark, user_id: bookmark.user_id + 1)
      expect(bookmark_with_another_user_id).to be_valid
    end
  end
end
