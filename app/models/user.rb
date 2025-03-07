class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :authentications, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  enum :gender, { gender_private: 0, male: 1, female: 2, others: 3 }


  def bookmark(spot)
    bookmarks.create(spot: spot) unless bookmark?(spot)
  end

  def unbookmark(spot)
    bookmarks.find_by(spot: spot)&.destroy
  end

  def bookmark?(spot)
    bookmarks.exists?(spot: spot)
  end

  def like(instrument)
    likes.create(instrument: instrument) unless like?(instrument)
  end

  def unlike(instrument)
    likes.find_by(instrument: instrument)&.destroy
  end

  def like?(instrument)
    likes.exists?(instrument: instrument)
  end

  def own?(object)
    id == object&.user_id
  end

  def self.from_omniauth(auth)
    user = find_by(email: auth.info.email) ||
           where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.name = auth.info.name
            user.email = auth.info.email
            user.password = Devise.friendly_token(10)
            user.gender = 0
           end
    user
  end
end
