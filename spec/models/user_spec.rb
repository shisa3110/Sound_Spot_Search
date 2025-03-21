require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let(:instrument) { create(:instrument, user: user) }

  describe "バリデーションのテスト" do
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
      # 最初のユーザーを作成
      user = create(:user)

      # 同じメールアドレスでユーザーを作成しようとしてエラーが発生することを確認
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include("は既に使用されています。")
    end
  end


  describe '#bookmark' do
    it 'スポットをブックマークできる' do
      expect { user.bookmark(spot) }.to change { user.bookmarks.count }.by(1)
    end

    it 'すでにブックマーク済みなら何もしない' do
      user.bookmark(spot)
      expect { user.bookmark(spot) }.not_to change { user.bookmarks.count }
    end
  end

  describe '#unbookmark' do
    it 'ブックマークを解除できる' do
      user.bookmark(spot)
      expect { user.unbookmark(spot) }.to change { user.bookmarks.count }.by(-1)
    end
  end

  describe '#like' do
    it '楽器をいいねできる' do
      expect { user.like(instrument) }.to change { user.likes.count }.by(1)
    end
    end

  describe '#unlike' do
    it 'いいねを解除できる' do
      user.like(instrument)
      expect { user.unlike(instrument) }.to change { user.likes.count }.by(-1)
    end
  end

  describe '#own?' do
    let(:spot) { create(:instrument, user: user) }

    it '自分のならtrueを返す' do
      expect(user.own?(instrument)).to be true
    end

    it '他人のオブジェクトならfalseを返す' do
      other_user = create(:user)
      expect(other_user.own?(instrument)).to be false
    end
  end
end
