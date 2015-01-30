class AddLocationInfoToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :loc_name, :string
    add_column :photos, :lat, :string
    add_column :photos, :long, :string
  end
end
