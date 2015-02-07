class AlbumController < ApplicationController

  def new
    #DO SOMETHING IF THE USER DOESNT HAVE ALBUM 
    AlbumPhoto.create(uid: current_user.id, photo_id: (params[:photo]["id"]), album_id: (params[:album_id]))
    #redirect_to root_path
  end
end
