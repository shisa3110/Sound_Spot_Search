require 'rails_helper'

RSpec.describe "Spots", type: :system do
  let(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'スポット作成' do
    it 'スポットを作成できる' do
      visit new_spot_path

      fill_in '施設名前', with: '新しいスポット'
      select '施設カテゴリ', from: 'Category'
      fill_in '住所', with: '東京都渋谷区1-1-1'
      fill_in '電話番号', with: '03-1234-5678'
      fill_in 'Webサイト', with: 'https://example.com'
      attach_file '施設の写真', Rails.root.join('spec/fixtures/files/test_image.png')

      click_button '作成'

      expect(page).to have_content '施設情報を作成しました'
      expect(page).to have_content '新しいスポット'
    end
  end

  describe 'スポット編集' do
    let(:spot) { create(:spot, user: user) }

    it 'スポットを編集できる' do
      visit edit_spot_path(spot)

      fill_in '施設名', with: '編集したスポット'
      click_button '更新'

      expect(page).to have_content '施設情報を保存しました'
      expect(page).to have_content '編集したスポット'
    end
  end

  describe 'スポット削除' do
    let(:spot) { create(:spot, user: user) }

    it 'スポットを削除できる' do
      visit spot_path(spot)

      click_link '削除'

      expect(page).to have_content '削除に成功しました'
      expect(page).not_to have_content spot.name
    end
  end
end