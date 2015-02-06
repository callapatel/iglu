class AlbumController < ApplicationController

  def new
    puts params
    AlbumPhoto.create(uid: current_user.id, photo_id: (params[:photo]["id"]), album_id: (params[:album_id]))
    #redirect_to root_path
  end
end
