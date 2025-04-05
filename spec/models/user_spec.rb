require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:spot) { create(:spot) }
  let(:instrument) { create(:instrument, user: user) }
  
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'nameがない場合、バリデーションが機能してinvalidエラーになるか' do
      user_without_name = build(:user, name: nil)
      expect(user_without_name).to be_invalid
    end

    it "メールアドレスがない場合は無効" do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).to be_invalid
    end

    it "パスワードが6文字未満だと無効" do
      user.password = "12345"
      user.password_confirmation = "12345"
      expect(user).to be_invalid
    end

    it "パスワードと確認用パスワードが一致しないと無効" do
      user.password = "password"
      user.password_confirmation = "differentpassword"
      expect(user).to be_invalid
    end

    it "重複したメールアドレスは無効" do
      user = create(:user)
      new_user = build(:user, email: user.email)
      expect(new_user).not_to be_valid
      expect(new_user.errors[:email]).to include("は既に使用されています。")
    end

    context 'password_required? が true の場合' do
      it 'password が空なら無効になる' do
        user = build(:user, password: '', password_confirmation: '')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("が入力されていません。") 
      end

      it 'password が6文字未満なら無効になる' do
        user = build(:user, password: '12345', password_confirmation: '12345')
        expect(user).to be_invalid
        expect(user.errors[:password]).to include("は6文字以上に設定して下さい。")
      end

      it 'password が6文字以上なら有効になる' do
        user = build(:user, password: '123456', password_confirmation: '123456')
        expect(user).to be_valid
      end
    end

    context 'password_required? が false の場合（既存ユーザーでパスワード未入力）' do
      it '既存ユーザーでパスワードを変更しなければ有効になる' do
        user = create(:user)
        user.name = "新しい名前"
        user.password = nil
        user.password_confirmation = nil
        expect(user).to be_valid
      end
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
