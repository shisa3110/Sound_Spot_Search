class User < ApplicationRecord
  has_many :spots
  has_many :bookmarks, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :gender, { gender_private: 0, male: 1, female: 2, others: 3, }


  def bookmark(spot)
    bookmarks.create(spot: spot) unless bookmark?(spot)
  end

  def unbookmark(spot)
    bookmarks.find_by(spot: spot)&.destroy
  end

  def bookmark?(spot)
    bookmarks.exists?(spot: spot)
  end
end
