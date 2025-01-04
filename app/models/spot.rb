class Spot < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  enum category: { studio:0, karaoke:1, public_facilities:2 }
end
