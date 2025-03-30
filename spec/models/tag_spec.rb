require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      tag = build(:tag)
      expect(tag).to be_valid
      expect(tag.errors).to be_empty
    end

    it 'nameがない場合、バリデーションが機能してinvalidエラーになるか' do
      tag_without_name = build(:spot, name: nil)
      expect(tag_without_name).to be_invalid
    end

    it '重複したnameが登録された場合、バリデーションが機能してinvalidエラーになるか' do
      tag = create(:tag)
      tag_with_duplicated = build(:tag, name: tag.name)
      expect(tag_with_duplicated).to be_invalid
    end

    it 'nameが重複していない場合、バリデーションエラーが起きないか'
      tag = create(:tag)
      tag_with_another = build(:tag, name: tag.name + "a")
      expect(tag_with_another).to be_valid
    end
  end
end
