class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :user_name, presence: true

  def self.from_omniauth(auth)
    # Either create a User record or update it based on the provider (Google) and the UID
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.user_name = auth.info.name
      user.image = auth.info.image
      user.id = auth.uid
      user.provider = auth.provider
    end
  end
end
