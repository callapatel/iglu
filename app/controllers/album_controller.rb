class AlbumController < ApplicationController

  def new
    #DO SOMETHING IF THE USER DOESNT HAVE ALBUM

    if params[:album_id] == "" || params[:album_id].nil?
      @gowithit = params[:album]["name"]
    else
      @gowithit = params[:album_id]
    end
    AlbumPhoto.create(uid: current_user.id, photo_id: (params[:photo]["id"]), album_id: @gowithit)
    redirect_to root_path
  end
end
