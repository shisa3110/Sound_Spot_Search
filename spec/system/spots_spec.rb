require 'rails_helper'

RSpec.describe "Spots", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe '施設情報作成' do
    it '施設情報を作成できる' do
      visit new_spot_path

      fill_in 'spot[name]', with: '新しい施設'
      fill_in 'spot[category]', with: 'studio'
      fill_in 'spot[address]', with: '東京都渋谷区1-1-1'
      fill_in 'spot[phone_number]', with: '03-1234-5678'
      fill_in 'spot[web_site]', with: 'https://example.com'
      attach_file 'spot[spot_image]', Rails.root.join('spec/fixtures/files/test_image.png')

      click_button '送信'

      expect(page).to have_content '施設情報を作成しました'
    end
  end

  describe '施設情報の編集' do
    let(:spot) { create(:spot, user: user) }

    it '施設情報を編集できる' do
      visit edit_spot_path(spot)

      fill_in "spot[name]", with: '編集したスポット'
      click_button '更新'

      expect(page).to have_content '施設情報が更新されました'
    end
  end

  describe '施設情報の削除' do
    let(:spot) { create(:spot, user: user) }

    it '施設情報を削除できる', js: true do
      visit spot_path(spot)

      expect(page).to have_selector("a[data-method='delete'][href='#{spot_path(spot)}']", visible: :all)
      find("a[data-method='delete'][href='#{spot_path(spot)}']").click

      expect(page).to have_content '削除に成功しました'
      expect(page).not_to have_content(spot.name)
    end
  end
end
