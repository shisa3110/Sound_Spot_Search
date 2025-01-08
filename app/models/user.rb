class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # enum gender: { gender_private: 0, male: 1, female: 2, others: 3 }

  def bookmark(spot)
    bookmarks << spot
  end

  def unbookmark(spot)
    bookmarks.destroy(spot)
  end

  def bookmark?(spot)
    bookmarks.include?(spot)
  end
end
