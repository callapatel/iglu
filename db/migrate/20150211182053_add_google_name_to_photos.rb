class AddGoogleNameToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :google_name , :string
  end
end
