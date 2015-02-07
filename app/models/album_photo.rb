class AlbumPhoto < ActiveRecord::Base
  belongs_to :album
  belongs_to :photo


  def self.checks_to_see_if_params_comes_from_dropdown_or_typed_it
    if @albumidfromparams == "" || @albumidfromparams.nil?
      @gowithit = @albumnamefromparams
      Album.create(a_name: @gowithit, uid: @this_here_now_person)
    else
      @gowithit = @albumidfromparams
      Album.create(a_name: @gowithit, uid: @this_here_now_person)
    end
    AlbumPhoto.create(uid: @this_here_now_person, photo_id: @photo_id_from_params_modal, album_id: @gowithit)
    raise
  end

end
