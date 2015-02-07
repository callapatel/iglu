class ChangeAlbumIdDataTypeInAlbumPhotosDb < ActiveRecord::Migration
  def up
    change_column :album_photos, :album_id, :string
  end

  def down
    change_column :album_photos, :album_id, :integer
  end
end
