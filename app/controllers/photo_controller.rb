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
    @abe = params[:search]
    if params[:search]
      @articles = Photo.where("google_name ILIKE ? or loc_name ILIKE ? or ig_user ILIKE ? or caption ILIKE ? or ig_user ILIKE ? or url ILIKE ? ", "%#{@abe}%", "%#{@abe}%", "%#{@abe}%", "%#{@abe}%", "%#{@abe}%", "%#{@abe}%")

    else
      puts "Sorry, you don't have any photos with that location currently."
    end
  end
end
