require 'rails_helper'

RSpec.describe "Instruments", type: :system do
  let(:user) { create(:user) }
  let!(:instrument) { create(:instrument, user: user) }

  before do
    # ユーザーがサインインする
    sign_in user
  end

  describe "GET /instruments" do
    it "my楽器の一覧が表示される" do
      visit instruments_path
      expect(page).to have_content(instrument.title)
    end
  end

  describe "GET /instruments/new" do
    it "my楽器を投稿するフォームが表示される" do
      visit new_instrument_path
      expect(page).to have_content("楽器の投稿")
    end
  end

  describe "POST /instruments" do
    context "有効なパラメータでmy楽器を投稿するとき" do
      it "インストゥルメントが作成され、一覧ページにリダイレクトする" do
        visit new_instrument_path
        fill_in "題名", with: "新しい楽器"
        fill_in "コメント", with: "これはテストの楽器です"
        select "violin", from: "楽器の種類"
        attach_file "my楽器写真", Rails.root.join("spec/fixtures/sample_instrument_image.jpg")
        click_button "送信"
        expect(page).to have_content("my楽器投稿に成功しました")
        expect(page).to have_content("新しい楽器")
      end
    end

    context "無効なパラメータでmy楽器を投稿するとき" do
      it "インストゥルメントの作成が失敗し、エラーメッセージが表示される" do
        visit new_instrument_path
        click_button "送信"
        expect(page).to have_content("投稿に失敗しました")
      end
    end
  end

  describe "GET /instruments/:id/edit" do
    it "my楽器投稿の編集フォームが表示される" do
      visit edit_instrument_path(instrument)
      expect(page).to have_content("楽器の編集")
    end
  end

  describe "PATCH /instruments/:id" do
    context "有効なパラメータでmy楽器投稿を編集するとき" do
      it "my楽器投稿が更新され、一覧ページにリダイレクトする" do
        visit edit_instrument_path(instrument)
        fill_in "題名", with: "更新した楽器"
        click_button "更新する"
        expect(page).to have_content("投稿の編集に成功しました")
        expect(page).to have_content("更新した楽器")
      end
    end

    context "無効なパラメータでmy楽器投稿を更新するとき" do
      it "インストゥルメントの更新が失敗し、エラーメッセージが表示される" do
        visit edit_instrument_path(instrument)
        fill_in "題名", with: ""
        click_button "送信"
        expect(page).to have_content("編集の保存に失敗しました")
      end
    end
  end

  describe "DELETE /instruments/:id" do
    it "インストゥルメントが削除され、一覧ページにリダイレクトする" do
      visit instruments_path
      find("a[data-method='delete'][href='#{instrument_path(instrument)}']").click
      expect(page).to have_content("削除に成功しました。")
      expect(page).to_not have_content(instrument.title)
    end
  end

  describe "GET /instruments/likes" do
    it "お気に入りの楽器が表示される" do
      visit likes_instruments_path
      expect(page).to have_content("お気に入りの楽器")
    end
  end
end