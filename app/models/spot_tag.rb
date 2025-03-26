class SpotTag < ApplicationRecord
  belongs_to :spot
  belongs_to :tag

  validates :spot_id, presence: true
  validates :tag_id, presence: true
end
