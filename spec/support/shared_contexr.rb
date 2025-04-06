RSpec.shared_context 'with_sign_in' do
  let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
  
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end  
end
