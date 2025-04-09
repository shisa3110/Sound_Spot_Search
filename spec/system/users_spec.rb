require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ユーザー登録' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }

    it '新規ユーザーを登録できる' do
      visit new_user_registration_path

      fill_in 'user_name', with: '新規ユーザー'
      fill_in 'user_email', with: 'new@example.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'ユーザー登録'

      expect(page).to have_content 'アカウント登録が完了しました'
    end
  end

  describe 'ログイン' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }

    it '既存ユーザーがログインできる' do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました。'
    end
  end

  describe 'ログアウト' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'

    it 'ログアウトできる' do
      login_as(user, scope: :user)
      visit root_path

      click_link 'ログアウト'

      expect(page).to have_content 'ログアウトしました。'
    end
  end
end
