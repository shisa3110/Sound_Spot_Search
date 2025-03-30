require 'rails_helper'

RSpec.describe SpotTag, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      spot_tag = build(:spot_tag)
      expect(spot).to be_valid
      expect(spot.errors).to be_empty
    end

    it 'spot_idがない場合、バリデーションが機能してinvalidエラーになるか' do
      without_spot_id = build(:spot_tag, spot_id: nil)
      expect(swithout_spot_id).to be_invalid
    end

    it 'user_idがない場合、バリデーションが機能してinvalidエラーになるか' do
      without_user_id = build(:spot_tag, user_id: nil)
      expect(swithout_user_id).to be_invalid
    end
  end
end
