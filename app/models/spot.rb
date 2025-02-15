class Spot < ApplicationRecord
  # spotが削除されると、spotと関連していたブックマークも削除される。
  has_many :bookmarks, dependent: :destroy
  has_many :spot_tags
  has_many :tags, through: :spot_tags
  
  #mount_uploader :spot_image, SpotImageUploader

  enum :category, { studio:0, karaoke:1, public_facilities:2 }

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
    tags.map(&:name).join(',')
  end
end
