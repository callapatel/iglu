class AddIgUserToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :ig_user , :string
  end
end
