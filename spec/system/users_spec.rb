require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, email: 'test@example.com', password: 'password') }

  before do
    driven_by(:rack_test)
  end

  describe 'ユーザー登録' do
    it '新規ユーザーを登録できる' do
      visit new_user_registration_path

      fill_in '名前', with: '新規ユーザー'
      fill_in 'Eメール', with: 'new@example.com'
      fill_in 'パスワード', with: 'password'
      fill_in 'パスワード（確認用）', with: 'password'
      click_button '登録'

      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end

  describe 'ログイン' do
    it '既存ユーザーがログインできる' do
      visit new_user_session_path

      fill_in 'Eメール', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_content 'ログインしました。'
    end
  end

  describe 'ログアウト' do
    it 'ログアウトできる' do
      login_as(user, scope: :user)
      visit root_path

      click_link 'ログアウト'

      expect(page).to have_content 'ログアウトしました。'
    end
  end
end