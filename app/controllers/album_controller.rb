class AlbumController < ApplicationController

  def new
    #DO SOMETHING IF THE USER DOESNT HAVE ALBUM

    @albumidfromparams = params[:album_id]
    puts 
    @albumnamefromparams = params[:album]["name"]
    @this_here_now_person = current_user.id
    @photo_id_from_params_modal = params[:photo]["id"]

    #so either one of these is nil from the user, either they chose from the dropped list or wrote it in and
    #if they wrote it in its sent to the same field as if it were selected from the dropped list into the db
    if @albumidfromparams == "" || @albumidfromparams.nil?
      @gowithit = @albumnamefromparams
      Album.create(a_name: @gowithit, uid: current_user.id)
    else
      @gowithit = @albumidfromparams
       Album.create(a_name: @gowithit, uid: current_user.id)
       raise
    end
    #AlbumPhoto.create(uid: current_user.id, photo_id: (params[:photo]["id"]), album_id: @gowithit)
    AlbumPhoto.create(uid: @this_here_now_person, photo_id: @photo_id_from_params_modal, album_id: @gowithit)

    redirect_to root_path
  end
end
