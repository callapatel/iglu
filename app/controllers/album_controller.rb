class AlbumController < ApplicationController

  def new
    puts params
    AlbumPhoto.create(photo_id: (params[:pid]))
  end
end
