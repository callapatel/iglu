class User < ActiveRecord::Base
  validates :username, :uid, :name, :token, presence: true
end
