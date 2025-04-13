class Tag < ApplicationRecord
  has_many :spot_tags, dependent: :destroy
  has_many :spots, through: :spot_tags

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name", "updated_at"]
  end
end
