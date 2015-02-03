class AlbumController < ApplicationController

  def new
    AlbumPhoto.create(uid: (params[:d]))
  end
end
