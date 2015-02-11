class AddYelpUrlToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :yelp_url , :text
  end
end
