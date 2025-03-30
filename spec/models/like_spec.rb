require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      like = build(:like)
      expect(like).to be_valid
      expect(like.errors).to be_empty
    end

    it '重複したuser_idが登録された場合、バリデーションが機能してinvalidエラーになるか' do
      like = create(:like)
      like_with_duplicated = build(:like, user_id: like.user_id)
      expect(like_with_duplicated).to be_invalid
    end

    it 'user_idが重複していない場合、バリデーションエラーが起きないか'
      like = create(:like)
      like_with_another = create(:like, user_id: like.user_id + 1)
      expect(like_with_another).to be_valid
    end
  end
end
