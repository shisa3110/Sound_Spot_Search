class Spot < ApplicationRecord
  belongs_to :users
  # spotが削除されると、spotと関連していたブックマークも削除される。
  has_many :bookmarks, dependent: :destroy
  has_many :spot_tags
  has_many :tags, through: :spot_tags

  enum :category, { studio:0, karaoke:1, public_facilities:2 }
end
