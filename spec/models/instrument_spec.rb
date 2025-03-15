require 'rails_helper'

RSpec.describe Instrument, type: :model do
    let(:instrument) { create(:instrument) }
  
    it "有効な楽器情報を持つ場合、バリデーションを通過する" do
      expect(instrument).to be_valid
    end
  
    it "タイトルがない場合、無効である" do
      instrument.title = nil
      expect(instrument).not_to be_valid
    end
  
    it "コメントがない場合、無効である" do
      instrument.comment = nil
      expect(instrument).not_to be_valid
    end
  
    it "画像がない場合、無効である" do
      instrument.instrument_image = nil
      expect(instrument).not_to be_valid
    end
  end
