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
      expect(page).to have_content("楽器を投稿する")
    end
  end

  describe "POST /instruments" do
    context "有効なパラメータでmy楽器を投稿するとき" do
      it "my楽器投稿が作成され、一覧ページにリダイレクトする" do
        visit new_instrument_path
        fill_in "instrument[title]", with: "新しい楽器"
        fill_in "instrument[comment]", with: "これはテストの楽器です"
        fill_in "instrument[kind]", with: "violin"
        attach_file "instrument[instrument_image]", Rails.root.join("spec/fixtures/sample_instrument_image.jpg")
        click_button "送信"
        expect(page).to have_content("my楽器を投稿しました")
      end
    end

    context "無効なパラメータでmy楽器を投稿するとき" do
      it "my楽器の作成が失敗し、エラーメッセージが表示される" do
        post instruments_path, params: { instrument: { name: '', category: '' } }

        visit current_path
        expect(page).to have_content("投稿に失敗しました")
      end
    end
  end

  describe "GET /instruments/:id/edit" do
    it "my楽器投稿の編集フォームが表示される" do
      visit edit_instrument_path(instrument)
      expect(page).to have_content("my楽器投稿編集")
    end
  end

  describe "PATCH /instruments/:id" do
    context "有効なパラメータでmy楽器投稿を編集するとき" do
      it "my楽器投稿が更新され、一覧ページにリダイレクトする" do
        visit edit_instrument_path(instrument)
        fill_in "instrument[title]", with: "更新した楽器"
        click_button "送信"
        expect(page).to have_content("投稿の編集に成功しました")
      end
    end

    context "無効なパラメータでmy楽器投稿を更新するとき" do
      it "my楽器投稿の更新が失敗し、エラーメッセージが表示される" do
        visit edit_instrument_path(instrument)
        fill_in "instrument[title]", with: ""
        click_button "送信"
        expect(page).to have_content("編集の保存に失敗しました")
      end
    end
  end

  describe "DELETE /instruments/:id" do
    it "my楽器投稿が削除され、一覧ページにリダイレクトする" do
      instrument = create(:instrument)
      visit instruments_path
      find("a[data-method='delete'][href='#{instrument_path(instrument)}']").click
      expect(page).to have_content("削除に成功しました。")
      expect(page).to_not have_content(instrument.title)
    end
  end

  describe "GET /instruments/likes" do
    it "お気に入りの楽器が表示される" do
      visit likes_instruments_path
      expect(page).to have_content("いいねした楽器たち")
    end
  end
end
