require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーションのテスト" do
    let(:user) { build(:user) }
    it "全ての値が適切なら有効である" do
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user.name = nil
      expect(user).to be_invalid
    end

    it "メールアドレスがない場合は無効" do
      user.email = nil
      expect(user).to be_invalid
    end

    it "パスワードが6文字未満だと無効" do
      user.password = "12345"
      user.password_confirmation = "12345"
      expect(user).to be_invalid
    end

    it "パスワードと確認用パスワードが一致しないと無効" do
      user.password_confirmation = "differentpassword"
      expect(user).to be_invalid
    end

    it "重複したメールアドレスは無効" do
      create(:user, email: user.email)
      expect(user).to be_invalid
    end
  end
end

