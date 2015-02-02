class AlbumController < ApplicationController

  def new
    @album = Album.find_by_uid(params[:uid])
    if @feed
      current_user.albums.create(uid: @feed)
    else
      current_user.albums.create(
      uid: params[:uid]) # missing username
    end
  end
end
