require 'rails_helper'

RSpec.describe "Spots", type: :system do

  describe '施設情報作成' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'


    it '施設情報を作成できる' do
      visit new_spot_path
      puts "現在のパス: #{current_path}"

      fill_in '施設名', with: '新しい施設'
      select 'スタジオ', from: "spot_category"
      fill_in 'spot_address', with: '東京都渋谷区1-1-1'
      fill_in 'spot_phone_number_', with: '00-0000-0000'
      fill_in 'spot_web_site', with: 'https://example.com'
      attach_file 'spot_spot_image', Rails.root.join('spec/fixtures/files/test_image.png')

      click_button '送信'

      expect(page).to have_content '施設情報を作成しました'
    end
  end

  describe '施設情報の編集' do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'
    let!(:spot) { create(:spot, user: user) }

    it '施設情報を編集できる' do
      visit edit_spot_path(spot)

      fill_in "spot_name", with: '編集したスポット'
      click_button '更新'

      expect(page).to have_content '施設情報が更新されました'
    end
  end

  describe '施設情報の削除' do
    include_context 'with_sign_in'
    let!(:spot) { create(:spot, user: user) }

    it '施設情報を削除できる', js: true do
      visit spot_path(spot)

      expect(page).to have_selector("a[data-method='delete'][href='#{spot_path(spot)}']", visible: :all)
      find("a[data-method='delete'][href='#{spot_path(spot)}']").click

      expect(page).to have_content '削除に成功しました'
      expect(page).not_to have_content(spot.name)
    end
  end
end
