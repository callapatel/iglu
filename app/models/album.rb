class Album < ActiveRecord::Base
  has_many :photos, through: :album_photos
  has_many :album_photos
end
