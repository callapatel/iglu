class AlbumController < ApplicationController

  def new
    puts params
    AlbumPhoto.create(uid: current_user.id, photo_id: (params[:pid]))
  end
end
