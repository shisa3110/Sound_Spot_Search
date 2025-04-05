require 'rails_helper'

RSpec.describe SpotTag, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      spot_tag = build(:spot_tag)
      expect(spot_tag).to be_valid
      expect(spot_tag.errors).to be_empty
    end

    it 'spot_idがない場合、バリデーションが機能してinvalidエラーになるか' do
      without_spot_id = build(:spot_tag, spot_id: nil)
      expect(without_spot_id).to be_invalid
    end

    it 'tag_idがない場合、バリデーションが機能してinvalidエラーになるか' do
      without_tag_id = build(:spot_tag, tag_id: nil)
      expect(without_tag_id).to be_invalid
    end
  end
end
