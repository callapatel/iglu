class PhotoController < ApplicationController

  def search

   params[:search]
      @articles = Photo.where("google_name = ?", params[:search])
    #  raise
    # else
    #   @articles = Photo.order("created_at DESC")
    # end
  end

  def view
    if params[:search]
      @articles = Photo.where("google_name = ?", params[:search])
    else
      @articles = Photo.order("created_at DESC")
    end
  end
end
