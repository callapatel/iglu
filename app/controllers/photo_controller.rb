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
      @articles = Photo.where("google_name = ? or loc_name = ?", params[:search], params[:search])
    
    else
      puts "Sorry, you don't have any photos with that location currently."
    end
  end
end
