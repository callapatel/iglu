class PhotoController < ApplicationController

  def search
  end

  def view
    if params[:search]
      @articles = Photo.search(params[:search]).order("created_at DESC")
    else
      @articles = Photo.order("created_at DESC")
    end
  end
end
