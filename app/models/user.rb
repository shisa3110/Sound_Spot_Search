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

  # パスワードのバリデーション（新規作成時のみ必須）
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?

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
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session["devise.google_data"]&.dig("extra", "raw_info"))
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def password_required?
    new_record? || password.present?
  end
end
