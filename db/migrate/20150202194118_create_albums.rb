class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :a_name
      t.string :uid

      t.timestamps null: false
    end
  end
end
