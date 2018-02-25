class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  # Github omniauth
  def self.find_for_github_auth(auth)
    p auth.extra.raw_info.followers
    p auth.extra.raw_info.following
    p auth.extra.raw_info.location
    p auth.extra.raw_info.public_repos

    user_params = {
      provider: auth.provider,
      uid: auth.uid,
      token: auth.credentials.token,
      email: auth.info.email,
      name: auth.info.name,
      nickname: auth.info.nickname,
      location: auth.extra.raw_info.location,
      github_image_url: auth.info.image,
      github_followers: auth.extra.raw_info.followers,
      github_following: auth.extra.raw_info.following,
      github_public_repos: auth.extra.raw_info.public_repos
    }

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email)
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]
      user.save
    end

    return user
  end

end
