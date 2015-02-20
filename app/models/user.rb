class User < ActiveRecord::Base
  validates :uid, :token, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    # Find or create a user
  end

  def self.createuser_from_omniauth(auth_hash)
      @user = User.create(
      name: auth_hash['info']['nickname'],
      uid: auth_hash['uid'],
      token: auth_hash["credentials"]['token'],
      )

  end




end
