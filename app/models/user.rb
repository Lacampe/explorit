class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  def self.find_for_github_auth(auth)
    p auth.credentials.token
    p auth.extra.raw_info.followers
    p auth.extra.raw_info.following
    p auth.extra.raw_info.location
    p auth.extra.raw_info.public_repos
    p auth.info.email
    p auth.info.image
    p auth.info.name
    p auth.info.nickname
    p auth.provider
    p auth.uid
  end
end
