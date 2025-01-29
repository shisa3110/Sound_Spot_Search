class SpotTag < ApplicationRecord
  belongs_to :spot
  belongs_to :tag
  #同じspot_idの中に、同じtag_idを2つ以上つけられないように、重複防止の制限。
  validates :tag_id, uniqueness: { scope: :spot_id }
end
