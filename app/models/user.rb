class User < ActiveRecord::Base
  validates :email, :username, :uid, :provider, presence: true
end
