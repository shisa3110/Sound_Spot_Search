class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :authentication, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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


  class << self
    def without_google_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        google = Authentication.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token(10)
        )
        google = Authentication.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user:, google: } 
    end

    def with_google_data(auth, )
      user = User.where(id: .user_id).first
      if user.blank?
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token(10)
        )
      end
      { user: }
    end

    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid:, provider:).first
      if authentication.present?
        user = with_google_data(auth, authentication)[:user]
        sns = authentication
      else
        user = without_google_data(auth)[:user]
        sns = without_google_data(auth)[:google]
      end
      { user:, google: }
    end
  end
end
