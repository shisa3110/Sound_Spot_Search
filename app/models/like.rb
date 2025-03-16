class Like < ApplicationRecord
  belongs_to :user
  belongs_to :instrument

  validates :user_id, uniqueness: { scope: :instrument_id }
end
