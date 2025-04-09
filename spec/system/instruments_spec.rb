require 'rails_helper'

RSpec.describe "Instruments", type: :system do

  describe "GET /instruments" do
    let!(:instrument) { FactoryBot.create(:instrument)}

    it "my楽器の一覧が表示される" do
      visit instruments_path
      expect(page).to have_content(instrument.title)
    end
  end

  describe "GET /instruments/new" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'

    it "ログイン後にmy楽器を投稿するフォームが表示される" do
      expect(page).to have_content("ログアウト")
      visit new_instrument_path
      expect(page).to have_content("楽器を投稿する")
    end
  end

  describe "POST /instruments" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'

    it "my楽器投稿が作成され、一覧ページにリダイレクトする" do
      visit new_instrument_path
      fill_in 'instrument_title', with: "新しい楽器"
      fill_in 'instrument_comment', with: "これはテストの楽器です"
      select 'バイオリン', from: "instrument_kind"
      attach_file 'instrument_instrument_image', Rails.root.join("spec/fixtures/files/test_image.png")
      click_button '送信'
      expect(page).to have_content("my楽器を投稿しました")
    end
  end
  

  describe "GET /instruments/:id/edit" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'
    let!(:instrument) { FactoryBot.create(:instrument, user: user)}

    it "my楽器投稿の編集フォームが表示される" do
      visit edit_instrument_path(instrument.id)
      expect(page).to have_content("my楽器投稿編集")
    end
  end

  describe "PATCH /instruments/:id" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'
    let!(:instrument) { FactoryBot.create(:instrument, user: user)}

    it "my楽器投稿が更新され、一覧ページにリダイレクトする" do
      visit edit_instrument_path(instrument.id)
      fill_in 'instrument_title', with: "更新した楽器"
      click_button "送信"
      expect(page).to have_content("投稿を編集しました")
    end
    it "my楽器投稿の更新が失敗し、エラーメッセージが表示される" do
      visit edit_instrument_path(instrument)
      fill_in 'instrument_title', with: ""
      click_button "送信"
      expect(page).to have_content("編集に失敗しました")
    end
  end

  describe "DELETE /instruments/:id" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'
    let!(:instrument) { FactoryBot.create(:instrument, user: user)}

    it "my楽器投稿が削除され、一覧ページにリダイレクトする" do
      visit instruments_path
      find("a[data-method='delete'][href='#{instrument_path(instrument)}']").click
      expect(page).to have_content("削除に成功しました。")
      expect(page).to_not have_content(instrument.title)
    end
  end

  describe "GET /instruments/likes" do
    let!(:user) { FactoryBot.create(:user, email: 'test@example.com', password: 'password') }
    include_context 'with_sign_in'
    let!(:instrument) { FactoryBot.create(:instrument, user: user)}

    it "お気に入りの楽器が表示される" do
      visit likes_instruments_path
      expect(page).to have_content("いいねした楽器たち")
    end
  end
end
