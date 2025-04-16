class Spot < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :spot_tags
  has_many :tags, through: :spot_tags
  has_many :reviews, dependent: :destroy
  belongs_to :user, optional: true

  mount_uploader :spot_image, SpotImageUploader

  enum :category, { studio: 0, karaoke: 1, public_facilities: 2 }

  validates :name, presence: true

  def save_with_tags(tag_names:)
    ActiveRecord::Base.transaction do
      self.tags = tag_names.map { |name| Tag.find_or_initialize_by(name: name.strip) }
      save!
    end
    true
  rescue StandardError
    false
  end

  def tag_names
    tags.map(&:name).join(",")
  end


  def self.ransackable_attributes(auth_object = nil)
    [ "address", "category", "created_at", "id", "latitude", "longitude", "name", "opening_hours", "phone_number", "place_id", "postal_code", "room_charge", "spot_image", "updated_at", "web_site" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "bookmarks", "reviews", "spot_tags", "tags" ]
  end
end
